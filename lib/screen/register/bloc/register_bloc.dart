import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pei_yee_session/common/model/user.dart';
import 'package:pei_yee_session/screen/register/model/register_form.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterUser>(_onRegisterUser);
  }

  Future<void> _onRegisterUser(
    RegisterUser event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());

    final response = await User.registerUser(event.registerForm);

    if (response?.isNotEmpty == true) {
      emit(RegisterSuccess(response!));
    } else {
      emit(const RegisterFailure("Registration failed. Please try again."));
    }
  }
}
