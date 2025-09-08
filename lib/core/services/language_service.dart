import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:learn_japan/core/utils/utils.dart';
import '../common/app_exceptions.dart';
import '/data/models/models.dart';

class LanguageService {
  Future<List<LanguageModel>> loadLanguages() async {
    try {
      final langCodesJson = await rootBundle.loadString(Assets.langCodes);
      final langFlagsJson = await rootBundle.loadString(Assets.langFlags);

      final langCodesMap = Map<String, String>.from(json.decode(langCodesJson));
      final langFlagsMap = Map<String, String>.from(json.decode(langFlagsJson));

      return langCodesMap.entries.map((entry) {
        final name = entry.key;
        final code = entry.value;
        final countryCode = langFlagsMap[name];

        return LanguageModel.fromJson(name, code, countryCode);
      }).toList();
    } catch (e) {
      throw Exception(
        "${AppExceptions().failToLoadDb} ${Assets.langCodes} & ${Assets.langFlags}: $e",
      );
    }
  }
}
