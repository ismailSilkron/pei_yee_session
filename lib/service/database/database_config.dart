import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:pei_yee_session/service/database/table/user_table.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConfig {
  Database? _db;

  static const String _dbName = "ojt.db";
  static const int _dbVersion = 2;

  // start singleton
  DatabaseConfig._internal();

  static final DatabaseConfig _instance = DatabaseConfig._internal();

  factory DatabaseConfig() {
    return _instance;
  }
  // end singleton

  Future<Database> get db async {
    _db ?? await initDB();

    if (_db != null) {
      return _db!;
    }

    throw Exception("Failed to init local db");
  }

  Future<void> initDB() async {
    try {
      Logger().i("start db");

      final String dbPath = join(await getDatabasesPath(), _dbName);

      Logger().i("Start init local db");

      _db = await openDatabase(
        dbPath,
        version: _dbVersion,
        onCreate: _onCreate,
        onUpgrade: (db, oldVersion, newVersion) async {
          if (newVersion > 1) {
            await UserTable.instance.createTable(db);
          }
        },
      );

      Logger().f("Success init local db");
    } catch (e, stackTrace) {
      Logger().e("Failed to start db, error: $e, stackTrace: $stackTrace");
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    Logger().i("Creating table....");
    UserTable.instance.createTable(db);
  }
}
