import 'package:chronicle_app/core/failure/failure.dart';
import 'package:chronicle_app/core/model/either.dart';
import 'package:chronicle_app/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:chronicle_app/features/auth/domain/model/user_model.dart';
import 'package:chronicle_app/features/auth/domain/repository/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;

  AuthRepositoryImpl({required this.authRemoteDatasource});

  @override
  Future<Either<Failure, UserModel>> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        return Either.left(AuthFailure(message: 'Google sign in cancelled'));
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final firebaseCredentials =
      await FirebaseAuth.instance.signInWithCredential(credential);

      final user = firebaseCredentials.user;
      if (user == null) {
        return Either.left(AuthFailure(message: 'Firebase user is null'));
      }

      final firebaseToken = await user.getIdToken();
      if (firebaseToken == null || firebaseToken.isEmpty) {
        return Either.left(AuthFailure(message: 'Firebase token is null/empty'));
      }

      final request =
      await authRemoteDatasource.loginWithGoogle(firebaseToken);

      return Either.right(request);

    } on DioException catch (e) {
      return Either.left(
          AuthFailure(message: e.response?.data['error'] ?? 'Server error'));
    } catch (e) {
      return Either.left(AuthFailure(message: 'Auth failure'));
    }
  }

  /*@override
  Future<Either<Failure, UserModel>> loginWithGoogle() async {
    try {
     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
     final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

     final credential = GoogleAuthProvider.credential(
       accessToken: googleAuth?.accessToken,
       idToken: googleAuth?.idToken,
     );

     final firebaseCredentials = await FirebaseAuth.instance.signInWithCredential(credential);
     final firebaseToken = await firebaseCredentials.user?.getIdToken();
     final request = await authRemoteDatasource.loginWithGoogle(firebaseToken!);

     return Either.right(request);
    } on DioException catch(e) {
      return Either.left(AuthFailure(message: e.response?.data['error']));
    } on Exception catch(e) {
      return Either.left(AuthFailure(message: 'Auth failure'));
    }
  }*/

}