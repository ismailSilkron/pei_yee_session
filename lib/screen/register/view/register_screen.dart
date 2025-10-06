import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pei_yee_session/screen/register/bloc/register_bloc.dart';
import 'package:pei_yee_session/screen/register/model/register_form.dart'
    show RegisterForm;
import 'package:pei_yee_session/widget/form/input_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _usernameController;
  late final TextEditingController _emailController;
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _passwordController;

  late final RegisterBloc _registerBloc;

  @override
  void initState() {
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _passwordController = TextEditingController();

    _registerBloc = RegisterBloc();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Register")),
        body: BlocConsumer<RegisterBloc, RegisterState>(
          bloc: _registerBloc,
          listener: (context, state) {
            if (context.mounted && state is RegisterSuccess) {
              _showSnackbar(context: context, message: "Success Register");
            }

            if (context.mounted && state is RegisterFailure) {
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
                      controller: _firstNameController,
                      label: "First Name",
                    ),
                    InputField(
                      controller: _lastNameController,
                      label: "Last Name",
                    ),
                    InputField(
                      controller: _usernameController,
                      label: "Username",
                    ),
                    InputField(
                      controller: _emailController,
                      label: "Email",
                      type: FieldType.email,
                      hintText: "example@gmail.com",
                    ),
                    InputField(
                      controller: _passwordController,
                      label: "Password",
                      type: FieldType.password,
                    ),

                    TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          print("sending data....");
                          // All validations passed, proceed with form submission
                          _registerBloc.add(
                            RegisterUser(
                              RegisterForm(
                                username: _usernameController.text,
                                email: _emailController.text,
                                firstName: _firstNameController.text,
                                lastName: _lastNameController.text,
                                password: _passwordController.text,
                              ),
                            ),
                          );
                        }

                        print("end....");
                      },
                      child: Text("Submit"),
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
