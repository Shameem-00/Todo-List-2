import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDatabase();

    return _database!;
  }

  static Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'todo.db');

    return await openDatabase(
      path,

      version: 1,

      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE todo(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            subtitle TEXT
          )
        ''');
      },
    );
  }
}
