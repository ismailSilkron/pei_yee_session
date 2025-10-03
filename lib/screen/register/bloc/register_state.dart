part of 'register_bloc.dart';

@immutable
sealed class RegisterState {
  const RegisterState();
}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterSuccess extends RegisterState {
  final String userId;

  const RegisterSuccess(this.userId);
}

final class RegisterFailure extends RegisterState {
  final String errorMessage;

  const RegisterFailure(this.errorMessage);
}
