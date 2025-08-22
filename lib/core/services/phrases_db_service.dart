import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '/data/models/models.dart';

class PhrasesDbService {
  static final PhrasesDbService _instance = PhrasesDbService._internal();

  factory PhrasesDbService() => _instance;

  PhrasesDbService._internal();

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDatabase();
    return _db!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDir = await getApplicationDocumentsDirectory();
    String path = join(documentsDir.path, "phrases_db.db");

    if (!await File(path).exists()) {
      ByteData data = await rootBundle.load("assets/phrases_db.db");
      List<int> bytes = data.buffer.asUint8List(
        data.offsetInBytes,
        data.lengthInBytes,
      );
      await File(path).writeAsBytes(bytes, flush: true);
    }

    return await openDatabase(path, readOnly: true);
  }

  Future<List<PhrasesTopicModel>> getAllTopics() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query("Topics");
    return maps.map((map) => PhrasesTopicModel.fromMap(map)).toList();
  }

  Future<List<PhrasesModel>> getPhrasesByTopic(int topicId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      "TopicPhrases",
      where: "TopicId = ?",
      whereArgs: [topicId],
    );
    return maps.map((map) => PhrasesModel.fromMap(map)).toList();
  }
}
