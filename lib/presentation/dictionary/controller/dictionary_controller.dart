import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:learn_japan/core/extensions/list_extension.dart';
import '../../../core/common/app_exceptions.dart';
import '/data/models/models.dart';
import '/core/services/services.dart';

class DictionaryController extends GetxController {
  final DictionaryDbService _dictionaryDbService;
  final TranslationService _translationService;

  DictionaryController({
    required DictionaryDbService dictionaryDbService,
    required TranslationService translationService,
  }) : _dictionaryDbService = dictionaryDbService,
       _translationService = translationService;

  var dictionaryData = <DictionaryModel>[].obs;
  var isLoading = true.obs;
  var translationsLoading = true.obs;
  var wordsTranslations = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(milliseconds: 350));
      final result = await _dictionaryDbService.getDictionaryData();
      dictionaryData.assignAll(result);
      await _translate(result);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _translate(List<DictionaryModel> data) async {
    translationsLoading.value = true;
    wordsTranslations.clear();

    try {
      final titles = data.map((e) => e.english).toList();
      final chunks = titles.chunked(10);

      debugPrint("🔹 Total words to translate: ${titles.length}");
      debugPrint("🔹 Number of chunks: ${chunks.length}");

      int processed = 0;

      for (var chunk in chunks) {
        debugPrint("➡️ Translating chunk: $chunk");

        for (var word in chunk) {
          String translation = "";
          int attempts = 0;

          while (attempts < 5) {
            try {
              final result = await _translationService.translateList([
                word,
              ], targetLanguage: 'ja');
              translation = result.first;
              debugPrint("   $word ➡️ $translation");
              break; // success, exit retry loop
            } catch (e) {
              attempts++;
              debugPrint("   $word ➡️ Attempt $attempts failed: $e");
              await Future.delayed(const Duration(milliseconds: 500));
            }
          }

          if (translation.isEmpty) {
            translation = "ERROR FOR THIS ONE...SKIPPING";
            debugPrint("   $word ➡️ $translation");
          }

          wordsTranslations.add(translation);
          processed++;
          debugPrint("✅ Progress: $processed / ${titles.length} translated");
        }
      }

      // 🔹 Print JSON mapping once done
      final jsonData = List.generate(
        dictionaryData.length,
        (i) => {
          "english": dictionaryData[i].english,
          "japanese": i < wordsTranslations.length ? wordsTranslations[i] : "",
        },
      );

      debugPrint("📦 Final JSON Data:");
      debugPrint(jsonEncode(jsonData));
    } catch (e) {
      debugPrint('${AppExceptions().failToTranslate}: $e');
    } finally {
      translationsLoading.value = false;
      debugPrint("🎉 Translation complete! Total: ${wordsTranslations.length}");
    }
  }
}
