import 'dart:convert';
import 'package:flutter/services.dart';
import '/core/common/app_exceptions.dart';
import '/core/utils/utils.dart';
import '/data/models/models.dart';

class KatakanaDbService {
  Future<KatakanaModel> loadData() async {
    try {
      final jsonString = await rootBundle.loadString(Assets.katakanaDb);
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      return KatakanaModel.fromJson(jsonMap);
    } catch (e) {
      throw Exception(
        "${AppExceptions().failToLoadDb} - ${Assets.katakanaDb}: $e",
      );
    }
  }
}
