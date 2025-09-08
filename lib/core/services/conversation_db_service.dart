import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '/core/common/app_exceptions.dart';
import '/core/utils/utils.dart';
import '/data/models/models.dart';

class ConversationDbService {
  Future<List<ConversationModel>> loadData() async {
    try {
      final jsonString = await rootBundle.loadString(Assets.conversationDb);
      final List<dynamic> jsonData = json.decode(jsonString);

      return jsonData.map((item) => ConversationModel.fromJson(item)).toList();
    } catch (e) {
      throw Exception(
        "${AppExceptions().failToLoadDb} - ${Assets.conversationDb}: $e",
      );
    }
  }
}
