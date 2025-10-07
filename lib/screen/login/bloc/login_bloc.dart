import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pei_yee_session/common/model/user.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginUser>(_onLoginUser);
  }

  Future<void> _onLoginUser(LoginUser event, Emitter<LoginState> emit) async {
    emit(LoginLoading());

    final response = await User.loginUser(
      username: event.username,
      password: event.password,
    );

    if (response.isSuccess) {
      emit(LoginSuccess(response.data!));
    } else {
      emit(LoginFailure(response.error?.message ?? "Failed to login"));
    }
  }
}
