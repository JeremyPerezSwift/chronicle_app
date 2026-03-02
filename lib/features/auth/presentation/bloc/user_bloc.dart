import 'package:chronicle_app/features/auth/domain/repository/auth_repository.dart';
import 'package:chronicle_app/features/auth/domain/repository/user_repository.dart';
import 'package:chronicle_app/features/auth/presentation/bloc/user_event.dart';
import 'package:chronicle_app/features/auth/presentation/bloc/user_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  /// Declare Events
  UserBloc({required this.authRepository, required this.userRepository})
      : super(UserState.initial()) {
    on<LoginWithGoogleEvent>(onLoginWithGoogleEvent);
    on<GetUserEvent>(onGetUser);
    on<LogoutEvent>(onLogoutEvent);
  }

  /// onLoginWithGoogleEvent
  Future onLoginWithGoogleEvent(
      LoginWithGoogleEvent event, Emitter emit) async {
    emit(state.copyWith(status: UserStatus.loading));

    var data = await authRepository.loginWithGoogle();

    if (data.isRight()) {
      emit(state.copyWith(status: UserStatus.success, userModel: data.right));
    } else {
      emit(state.copyWith(
          status: UserStatus.error, errorMessage: data.left.message));
    }
  }

  /// onGetUser
  /*Future onGetUser(GetUserEvent event, Emitter emit) async {
    emit(state.copyWith(status: UserStatus.loading));

    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser == null) {
      emit(state.copyWith(
        status: UserStatus.error,
        errorMessage: 'No Firebase session yet',
      ));
      return;
    }

    final data = await userRepository.getUser();

    if (data.isRight()) {
      emit(state.copyWith(status: UserStatus.success, userModel: data.right));
    } else {
      emit(state.copyWith(status: UserStatus.error, errorMessage: data.left.message));
    }
  }*/

  Future onGetUser(GetUserEvent event, Emitter emit) async {
    emit(state.copyWith(status: UserStatus.loading));

    var data = await userRepository.getUser();

    if (data.isRight()) {
      emit(state.copyWith(status: UserStatus.success, userModel: data.right));
    } else {
      emit(state.copyWith(
        status: UserStatus.error,
        errorMessage: data.left.message,
      ));
    }
  }

  Future onLogoutEvent(LogoutEvent event, Emitter emit) async {
    emit(state.copyWith(status: UserStatus.loading));

    var result = await authRepository.logout();

    if (result.isRight()) {
      emit(state.copyWith(status: UserStatus.logout));
    } else {
      emit(state.copyWith(
        status: UserStatus.error,
        errorMessage: result.left.message,
      ));
    }
  }
}
