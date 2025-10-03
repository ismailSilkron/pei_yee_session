part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {
  const RegisterEvent();
}

final class RegisterUser extends RegisterEvent {
  final RegisterForm registerForm;

  const RegisterUser(this.registerForm);
}
