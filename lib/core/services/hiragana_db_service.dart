import 'dart:convert';
import 'package:flutter/services.dart';
import '/core/common/app_exceptions.dart';
import '/core/utils/utils.dart';
import '/data/models/models.dart';

class HiraganaDbService {
  Future<HiraganaModel> loadData() async {
    try {
      final jsonString = await rootBundle.loadString(Assets.hiraganaDb);
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      return HiraganaModel.fromJson(jsonMap);
    } catch (e) {
      throw Exception(
        "${AppExceptions().failToLoadDb} - ${Assets.hiraganaDb}: $e",
      );
    }
  }
}
