import '/data/models/models.dart';
import '/core/helper/helper.dart';

class DictionaryDbService {
  final DbHelper _dbHelper;
  DictionaryDbService({required DbHelper dbHelper}) : _dbHelper = dbHelper;

  Future<List<DictionaryModel>> getDictionaryData() async {
    final db = _dbHelper.getDb('dictionary_db');
    final List<Map<String, dynamic>> maps = await db.query('dictionary');
    return maps.map((map) => DictionaryModel.fromMap(map)).toList();
  }
}
