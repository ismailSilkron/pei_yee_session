import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pei_yee_session/config/router/path_route.dart';
import 'package:pei_yee_session/screen/login/bloc/login_bloc.dart';
import 'package:pei_yee_session/widget/form/input_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _usernameController;

  late final TextEditingController _passwordController;

  late final LoginBloc _loginBloc;

  @override
  void initState() {
    _usernameController = TextEditingController();

    _passwordController = TextEditingController();

    _loginBloc = LoginBloc();

    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Login")),
        body: BlocConsumer<LoginBloc, LoginState>(
          bloc: _loginBloc,
          listener: (context, state) async {
            if (context.mounted && state is LoginSuccess) {
              await Navigator.of(context).pushReplacementNamed(
                PathRoute.profileScreen,
                arguments: {"user_id": state.userId},
              );
            }

            if (context.mounted && state is LoginFailure) {
              _showSnackbar(
                context: context,
                message: state.errorMessage,
                bgColor: Theme.of(context).colorScheme.error,
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: EdgeInsetsDirectional.symmetric(
                horizontal: 20,
                vertical: 50,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  spacing: 20,
                  children: [
                    InputField(
                      controller: _usernameController,
                      label: "Username",
                    ),

                    InputField(
                      controller: _passwordController,
                      label: "Password",
                      type: FieldType.password,
                    ),

                    TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // All validations passed, proceed with form submission
                          _loginBloc.add(
                            LoginUser(
                              username: _usernameController.text,
                              password: _passwordController.text,
                            ),
                          );
                        }
                      },
                      child: Text("Login"),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

void _showSnackbar({
  required BuildContext context,
  required String message,
  Color bgColor = Colors.green,
}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message), backgroundColor: bgColor));
}
