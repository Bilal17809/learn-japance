import '../helper/db_helper.dart';
import '/data/models/models.dart';

class ConvoDbService {
  final DbHelper _dbHelper;
  ConvoDbService({required DbHelper dbHelper}) : _dbHelper = dbHelper;

  Future<List<ConvoModel>> getAllConvo() async {
    final db = _dbHelper.getDb("phrases_db");
    final maps = await db.query("tbl_conversation");
    return maps.map((map) => ConvoModel.fromMap(map)).toList();
  }
}
