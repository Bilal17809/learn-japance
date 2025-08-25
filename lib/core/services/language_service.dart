import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:learn_japan/core/utils/utils.dart';
import '../common/app_exceptions.dart';
import '/data/models/models.dart';

class LanguageService {
  Future<List<LanguageModel>> loadLanguages() async {
    try {
      final lngCodesJson = await rootBundle.loadString(Assets.lngCodes);
      final lngFlagsJson = await rootBundle.loadString(Assets.lngFlags);

      final lngCodesMap = Map<String, String>.from(json.decode(lngCodesJson));
      final lngFlagsMap = Map<String, String>.from(json.decode(lngFlagsJson));

      return lngCodesMap.entries.map((entry) {
        final name = entry.key;
        final code = entry.value;
        final countryCode = lngFlagsMap[name];

        return LanguageModel.fromJson(name, code, countryCode);
      }).toList();
    } catch (e) {
      throw Exception(
        "${AppExceptions().failToLoadDb} ${Assets.lngCodes} & ${Assets.lngFlags}: $e",
      );
    }
  }
}
