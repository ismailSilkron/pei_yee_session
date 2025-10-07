part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {
  const LoginEvent();
}

final class LoginUser extends LoginEvent {
  final String username;
  final String password;

  const LoginUser({required this.username, required this.password});
}
