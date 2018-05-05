import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:bank_account/database/database_helper.dart';
import 'package:meta/meta.dart';

abstract class Provider {
  Database _db;

  @protected
  Future<Database> get db async {
    if (_db != null)
      return _db;

    await open();
    return _db;
  }

  Future open() async {
    String path = await DatabaseHelper.getDatabasePath();
//    await deleteDatabase(path);
    _db = await openDatabase(path, version: 1, onCreate: onCreate);
  }

  @protected
  void onCreate(Database db, int version);
}