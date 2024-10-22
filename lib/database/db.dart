import 'package:xym/model/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  static Future<Database> _openDB() async {
    return openDatabase(join(await getDatabasesPath(), 'xym.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT, username TEXT, password TEXT)');
    }, version: 1);
  }

  static Future<bool> insert(User user) async {
    Database database = await _openDB();
    await database.rawInsert(
        'INSERT INTO users (name,username,password) VALUES(?,?,?)',
        [user.name, user.username, user.password]);
    return true;
  }

  static Future<Database> _openDBExcersises() async {
    return openDatabase(join(await getDatabasesPath(), 'xym.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE excersises (id INTEGER PRIMARY KEY, userId INTEGER, day INTEGER, month INTEGER, year INTEGER, time INTEGER)');
    }, version: 2);
  }
}
