import 'package:pei_yee_session/screen/register/model/register_form.dart';

class User {
  final String userId;
  final String username;
  final String firstName;
  final String lastName;
  final String email;

  const User({
    required this.userId,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  static Future<String?> registerUser(RegisterForm registerForm) async {
    // TODO save user info to db, and sent user id

    return "123";
  }
}
