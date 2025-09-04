import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '/core/common/app_exceptions.dart';
import '/core/utils/utils.dart';
import '/data/models/models.dart';

class ConvoDbService {
  Future<List<ConvoModel>> loadConvoData() async {
    try {
      final jsonString = await rootBundle.loadString(Assets.convoDb);
      final List<dynamic> jsonData = json.decode(jsonString);

      return jsonData.map((item) => ConvoModel.fromJson(item)).toList();
    } catch (e) {
      throw Exception(
        "${AppExceptions().failToLoadDb} - ${Assets.convoDb}: $e",
      );
    }
  }
}
