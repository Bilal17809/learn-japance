import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '/data/models/models.dart';
import '/core/services/services.dart';

class JlptKanjiController extends GetxController {
  final TtsService _ttsService;
  final KanjiDbService _kanjiDbService;

  var kanjiData = <KanjiModel>[].obs;
  final targetLanguage = Rx<LanguageModel>(
    LanguageModel(name: 'Japanese', code: 'ja', ttsCode: 'ja-JP'),
  );
  var isLoading = true.obs;

  JlptKanjiController({
    required TtsService ttsService,
    required KanjiDbService kanjiDbService,
  }) : _ttsService = ttsService,
       _kanjiDbService = kanjiDbService;

  @override
  void onInit() {
    super.onInit();
    _loadKanjiData();
  }

  Future<void> _loadKanjiData() async {
    isLoading.value = true;
    try {
      await Future.delayed(const Duration(milliseconds: 200));
      final kanjiModel = await _kanjiDbService.loadData();
      kanjiData.assignAll(kanjiModel);
    } catch (e) {
      debugPrint("Error loading characters: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void onSpeak(String text) {
    _ttsService.speak(text, targetLanguage.value);
  }

  @override
  void onClose() {
    _ttsService.stop();
    super.onClose();
  }
}
