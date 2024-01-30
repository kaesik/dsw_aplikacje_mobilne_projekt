import 'package:dsw_aplikacje_mobilne_projekt/models/user_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class UserDatabase {
  static const int _version = 1;
  static const String _dbName = "Users.db";

  static const table = 'User';
  static const columnId = 'id';
  static const columnName = 'name';
  static const columnEmail = 'email';
  static const columnPassword = 'password';

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => await db.execute('''
            CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $columnEmail TEXT NOT NULL,
            $columnPassword TEXT NOT NULL
            );'''), version: _version);
  }

  static Future<int> addUser(User user) async {
    final db = await _getDB();
    return await db.insert("User", user.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateUser(User user) async {
    final db = await _getDB();
    return await db.update('User', user.toJson(),
        where: 'id = ?',
        whereArgs: [user.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteUser(User user) async {
    final db = await _getDB();
    return await db.delete(
      'User',
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  static Future<User?> getLoginUser(String email, String password) async {
    final db = await _getDB();
    final user = await db.query('User',
        where: 'email = ? AND password = ?',
        whereArgs: [email, password],
        limit: 1);

    if (user.isEmpty) {
      return null;
    }

    return User.fromJson(user.first);
  }

  static Future<List<User>?> getAllUsers() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query('User');

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(maps.length, (index) => User.fromJson(maps[index]));
  }

  static Future<User?> getUser(int id) async {
    final db = await _getDB();
    final user =
        await db.query('User', where: 'id = ?', whereArgs: [id], limit: 1);

    if (user.isEmpty) {
      return null;
    }

    return User.fromJson(user.first);
  }
}
