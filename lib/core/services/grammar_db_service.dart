import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:learn_japan/core/common/app_exceptions.dart';
import '/data/models/models.dart';

class GrammarDbService {
  Future<List<GrammarModel>> loadGrammarData() async {
    try {
      final jsonString = await rootBundle.loadString(
        'assets/japanese_dataset.json',
      );
      final List<dynamic> jsonData = json.decode(jsonString);

      return jsonData.map((item) => GrammarModel.fromJson(item)).toList();
    } catch (e) {
      throw Exception(
        "${AppExceptions().failToLoadDb} assets/japanese_dataset.json: $e",
      );
    }
  }
}
