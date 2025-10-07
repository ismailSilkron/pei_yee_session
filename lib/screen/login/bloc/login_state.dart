part of 'login_bloc.dart';

@immutable
sealed class LoginState {
  const LoginState();
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final String userId;

  const LoginSuccess(this.userId);
}

final class LoginFailure extends LoginState {
  final String errorMessage;

  const LoginFailure(this.errorMessage);
}
