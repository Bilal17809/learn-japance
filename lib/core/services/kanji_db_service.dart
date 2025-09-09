import 'dart:convert';
import 'package:flutter/services.dart';
import '/core/common/app_exceptions.dart';
import '/core/utils/utils.dart';
import '/data/models/models.dart';

class KanjiDbService {
  Future<List<KanjiModel>> loadData() async {
    try {
      final jsonString = await rootBundle.loadString(Assets.kanjiDb);
      final List<dynamic> jsonData = json.decode(jsonString);

      return jsonData.map((item) => KanjiModel.fromJson(item)).toList();
    } catch (e) {
      throw Exception(
        "${AppExceptions().failToLoadDb} - ${Assets.kanjiDb}: $e",
      );
    }
  }
}
