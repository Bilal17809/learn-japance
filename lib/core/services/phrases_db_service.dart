import '/core/helper/db_helper.dart';
import '/data/models/models.dart';

class PhrasesDbService {
  final DbHelper _dbHelper;
  PhrasesDbService({required DbHelper dbHelper}) : _dbHelper = dbHelper;

  Future<List<PhrasesTopicModel>> getAllTopics() async {
    final db = _dbHelper.getDb("phrases_db");
    final List<Map<String, dynamic>> maps = await db.query("Topics");
    return maps.map((map) => PhrasesTopicModel.fromMap(map)).toList();
  }

  Future<List<PhrasesModel>> getPhrasesByTopic(int topicId) async {
    final db = _dbHelper.getDb("phrases_db");
    final maps = await db.query(
      "TopicPhrases",
      where: "TopicId = ?",
      whereArgs: [topicId],
    );
    return maps.map((map) => PhrasesModel.fromMap(map)).toList();
  }
}
