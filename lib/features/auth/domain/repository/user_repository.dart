import 'package:chronicle_app/core/failure/failure.dart';
import 'package:chronicle_app/core/model/either.dart';
import 'package:chronicle_app/features/auth/domain/model/user_model.dart';

abstract class UserRepository {
  Future<Either<Failure, UserModel>> getUser();
}