import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AuthService {
  // Método para verificar las credenciales del usuario

  static Future<Database> _openDB() async {
    return openDatabase(join(await getDatabasesPath(), 'xym.db'),
        onCreate: (db, version) {
      db.execute('DROP TABLE users');
      db.execute('DROP excersises users');
      db.execute(
          'CREATE TABLE excersises (id INTEGER PRIMARY KEY, userId TEXT, day TEXT, month TEXT, year TEXT, date DATETIME, time INTEGER)');
      return db.execute(
          'CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT, username TEXT, password TEXT, gender TEXT, height INTEGER, age INTEGER, weight INTEGER, objetives TEXT)');
    }, version: 3);
  }

  static Future<Database> _openDBExcersises() async {
    return openDatabase(join(await getDatabasesPath(), 'xym.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE excersises (id INTEGER PRIMARY KEY, userId TEXT, day TEXT, month TEXT, year TEXT, date DATETIME, time INTEGER)');
    }, version: 1);
  }

  Future<int> validate(String username, String password) async {
    Database database = await _openDB();
    var id = await database.rawInsert(
        'INSERT INTO users (name,username,password) VALUES(?,?,?)',
        [username, password]);
    return id;
  }

  Future<List> signIn(String username, String password) async {
    Database database = await _openDB();
    var list = await database.rawQuery(
        'SELECT * FROM users WHERE username = ? AND password = ?',
        [username, password]);
    return list;
  }
}
