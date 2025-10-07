import 'package:pei_yee_session/service/database/table_template.dart';
import 'package:sqflite/sqflite.dart';

class UserTable extends TableTemplate {
  final String userNameCol;
  final String firstNameCol;
  final String lastNameCol;
  final String emailCol;
  final String passwordCol;

  const UserTable._internal()
    : userNameCol = "username",
      firstNameCol = "first_name",
      lastNameCol = "last_name",
      emailCol = "email",
      passwordCol = "password",
      super(tableName: "user");

  static const UserTable instance = UserTable._internal();

  @override
  String get createTableQuery => '''
      CREATE TABLE IF NOT EXISTS $tableName (
        $idCol INTEGER PRIMARY KEY AUTOINCREMENT,
        $createdCol TEXT NOT NULL,
        $updatedCol TEXT NOT NULL,
        $userNameCol TEXT NOT NULL,
        $firstNameCol TEXT NOT NULL,
        $lastNameCol TEXT NOT NULL,
        $emailCol TEXT NOT NULL,
        $passwordCol TEXT NOT NULL,
        $remarkCol TEXT,
        $referenceCol TEXT,
        $isDeletedCol INTEGER NOT NULL DEFAULT 0
      )
    ''';

  static Future<Map<String, dynamic>?> addUser({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    bool catchErrMsg = false,
  }) async {
    try {
      final UserTable userTable = UserTable.instance;

      final Database db = await userTable.database;

      final userExistingData = await db.query(
        userTable.tableName,
        where: "${userTable.emailCol} = ?",
        whereArgs: [email],
      );

      if (userExistingData.isNotEmpty) {
        throw Exception("Account registered with this email already exist");
      }

      final int userId = await userTable.insertRecord({
        userTable.userNameCol: username,
        userTable.firstNameCol: firstName,
        userTable.lastNameCol: lastName,
        userTable.emailCol: email,
        userTable.passwordCol: password,
      });

      if (userId == -1) {
        throw Exception("Failed to add user.");
      }

      final Map<String, dynamic>? userData = await userTable.getOneRecord(
        userId,
      );

      if (userData == null) {
        throw Exception("User not found after insertion");
      }

      return userData;
    } catch (e) {
      if (catchErrMsg) {
        rethrow;
      }

      return null;
    }
  }

  static Future<Map<String, dynamic>?> loginUser({
    required String username,
    required String password,
  }) async {
    try {
      final UserTable userTable = UserTable.instance;

      final Database db = await userTable.database;

      final userDetail = await db.query(
        userTable.tableName,
        where: "${userTable.userNameCol} = ? AND ${userTable.passwordCol} = ?",
        whereArgs: [username, password],
        limit: 1,
      );

      if (userDetail.isEmpty) {
        throw Exception("User not found");
      }

      final userResult = userDetail.first;

      return {"id": userResult[userTable.idCol].toString()};
    } catch (e) {
      return null;
    }
  }
}
