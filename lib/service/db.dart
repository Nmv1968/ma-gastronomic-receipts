import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  Future<Database> initDb() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, 'xym.db');

    // Abre la base de datos (y crea si no existe)
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int newVersion) async {
    // Crea las tablas en la base de datos
    db.execute(
        'CREATE TABLE excersises (id INTEGER PRIMARY KEY, userId TEXT, day TEXT, month TEXT, year TEXT, date DATETIME, time INTEGER)');
    db.execute(
        'CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT, username TEXT, password TEXT, gender TEXT, height INTEGER, age INTEGER, weight INTEGER, objetives TEXT)');
    // Puedes agregar más tablas aquí si es necesario
  }
}
