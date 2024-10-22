import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class UserService {
  static Future<Database> _openDB() async {
    return openDatabase(join(await getDatabasesPath(), 'xym.db'),
        onCreate: (db, version) {
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
          'CREATE TABLE excersises (id INTEGER PRIMARY KEY, userId INTEGER, day INTEGER, month INTEGER, year INTEGER, time INTEGER)');
    }, version: 2);
  }

  Future<int> insert(String fullname, String username, String password) async {
    Database database = await _openDB();
    var id = await database.rawInsert(
        'INSERT INTO users (name,username,password) VALUES(?,?,?)',
        [fullname, username, password]);
    return id;
  }

  Future<List> getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('id') ?? '';
    Database database = await _openDB();
    var list =
        await database.rawQuery('SELECT * FROM users WHERE id = ?', [id]);
    return list;
  }

  Future<List> update(
      String gender, String height, String age, String weight) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('id') ?? '';
    Database database = await _openDB();
    return await database.rawQuery(
        'UPDATE users SET gender =?, height = ?, age = ?, weight = ? WHERE id = ?',
        [gender, height, age, weight, id]);
  }

  Future<List> updateObjetives(objetives) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('id') ?? '';
    Database database = await _openDB();
    return await database.rawQuery('UPDATE users SET objetives =? WHERE id = ?',
        [objetives.join(', '), id]);
  }

  Future<List> listAllUser() async {
    Database database = await _openDB();
    return await database.rawQuery('SELECT * FROM users');
  }

  Future<List> insertExcersises(int time) async {
    DateTime now = DateTime.now();

    int day = now.day;
    int month = now.month;
    int year = now.year;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('id') ?? '';
    Database database = await _openDBExcersises();
    return await database.rawQuery(
        'INSERT INTO excersises (userId,day,month,year,time) VALUES (?,?,?,?,?)',
        [id, day, month, year, time]);
  }
}
