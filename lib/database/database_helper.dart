import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {

  static Future<String> getDatabasePath() async {
    io.Directory documentsDirectory =  await getApplicationDocumentsDirectory();
    return join(documentsDirectory.path, "main.db");
  }
}