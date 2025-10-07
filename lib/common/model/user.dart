import 'package:pei_yee_session/common/model/error_entity.dart';
import 'package:pei_yee_session/common/model/result.dart';
import 'package:pei_yee_session/screen/register/model/register_form.dart';
import 'package:pei_yee_session/service/database/table/user_table.dart';

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

  @override
  String toString() =>
      "User{ userId: $userId, username: $username, firstName: $firstName, lastName: $lastName, email: $email }";

  static User fromJson(Map<String, dynamic> json) {
    return User(
      userId: json["id"] ?? "",
      username: json["username"] ?? "",
      firstName: json["first_name"] ?? "",
      lastName: json["last_name"] ?? "",
      email: json["email"] ?? "",
    );
  }

  static Future<Result<String>> registerUser(RegisterForm registerForm) async {
    User? userDetail;
    ErrorEntity? error;
    try {
      final response = await UserTable.addUser(
        username: registerForm.username,
        firstName: registerForm.firstName,
        lastName: registerForm.lastName,
        email: registerForm.email,
        password: registerForm.password,
        catchErrMsg: true,
      );

      if (response == null) {
        throw Exception("API error");
      }

      userDetail = fromJson(response);
    } catch (e) {
      error = ErrorEntity(code: 100101, message: "Failed to Register");
    }

    return Result(data: userDetail?.userId, error: error);
  }

  static Future<Result<String>> loginUser({
    required String username,
    required String password,
  }) async {
    String? userId;
    ErrorEntity? error;

    try {
      final response = await UserTable.loginUser(
        username: username,
        password: password,
      );

      if (response == null) {
        throw Exception("Account not found");
      }

      if (response.containsKey("id") &&
          response["id"] is String &&
          (response["id"] as String).isNotEmpty) {
        userId = response["id"];
      }
    } catch (e) {
      error = ErrorEntity(code: 100101, message: "Failed to Login");
    }

    return Result(data: userId, error: error);
  }
}
