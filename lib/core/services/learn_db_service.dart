import '/core/helper/helper.dart';
import '/data/models/models.dart';

class LearnDbService {
  final DbHelper _dbHelper;
  LearnDbService({required DbHelper dbHelper}) : _dbHelper = dbHelper;

  Future<List<LearnTopicModel>> getAllTopics() async {
    final db = _dbHelper.getDb("learn_japanese");
    final List<Map<String, dynamic>> maps = await db.query('category');
    return maps.map((map) => LearnTopicModel.fromMap(map)).toList();
  }

  Future<List<LearnModel>> getCatByTopic(int topicId) async {
    final db = _dbHelper.getDb("learn_japanese");
    final List<Map<String, dynamic>> maps = await db.query(
      'tempt',
      where: "category_id = ?",
      whereArgs: [topicId],
    );
    return maps.map((map) => LearnModel.fromMap(map)).toList();
  }
}
