import 'dart:io';
import 'package:flutter/services.dart';
import '/core/common/app_exceptions.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();
  factory DbHelper() => _instance;
  DbHelper._internal();

  final Map<String, Database> _databases = {};

  Future<Database> initDatabase(
    String key,
    String assetPath, {
    bool readOnly = true,
  }) async {
    if (_databases.containsKey(key)) {
      return _databases[key]!;
    }

    Directory documentsDir = await getApplicationDocumentsDirectory();
    String dbPath = join(documentsDir.path, basename(assetPath));

    if (!await File(dbPath).exists()) {
      ByteData data = await rootBundle.load(assetPath);
      List<int> bytes = data.buffer.asUint8List(
        data.offsetInBytes,
        data.lengthInBytes,
      );
      await File(dbPath).writeAsBytes(bytes, flush: true);
    }

    final db = await openDatabase(dbPath, readOnly: readOnly);
    _databases[key] = db;
    return db;
  }

  Database getDb(String key) {
    if (!_databases.containsKey(key)) {
      throw Exception("${AppExceptions().failToLoadDb}: $key");
    }
    return _databases[key]!;
  }

  Future<void> closeAllDatabases() async {
    for (var db in _databases.values) {
      await db.close();
    }
    _databases.clear();
  }
}
