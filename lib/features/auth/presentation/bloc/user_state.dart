import 'package:chronicle_app/features/auth/domain/model/user_model.dart';

enum UserStatus {
  initial,
  loading,
  success,
  error,
}

class UserState {
  final UserStatus status;
  final String? errorMessage;
  final UserModel? userModel;

  UserState._({required this.status, this.userModel, this.errorMessage});

  factory UserState.initial() => UserState._(status: UserStatus.initial);

  UserState copyWith(
      {UserStatus? status, UserModel? userModel, String? errorMessage}) {
    return UserState._(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      userModel: userModel ?? this.userModel,
    );
  }
}
