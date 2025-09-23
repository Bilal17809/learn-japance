import 'dart:math';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '/core/common/app_exceptions.dart';
import '/core/theme/theme.dart';
import '/core/services/services.dart';
import '/data/models/models.dart';

class JwsController extends GetxController {
  final TtsService _ttsService;
  final HiraganaDbService _hiraganaDbService;
  final KatakanaDbService _katakanaDbService;

  var hiraganaData = Rx<HiraganaModel?>(null);
  var katakanaData = Rx<KatakanaModel?>(null);
  var kanjiData = <KanjiModel>[].obs;

  final targetLanguage = Rx<LanguageModel>(
    LanguageModel(name: 'Japanese', code: 'ja', ttsCode: 'ja-JP'),
  );
  final selectedWord = ''.obs;
  var boxColors = <String, Color>{}.obs;
  var isLoading = true.obs;

  JwsController({
    required TtsService ttsService,
    required HiraganaDbService hiraganaDbService,
    required KatakanaDbService katakanaDbService,
  }) : _ttsService = ttsService,
       _hiraganaDbService = hiraganaDbService,
       _katakanaDbService = katakanaDbService;

  @override
  void onInit() {
    super.onInit();
    _loadAllCharacters();
  }

  void setArguments(String selectedWord) {
    boxColors.clear();
    this.selectedWord.value = selectedWord;
    boxColors[selectedWord] = AppColors.primary(Get.context!);
  }

  Future<void> _loadAllCharacters() async {
    isLoading.value = true;
    try {
      await Future.delayed(const Duration(milliseconds: 200));
      final hiraganaModel = await _hiraganaDbService.loadData();
      hiraganaData.value = hiraganaModel;
      final katakanaModel = await _katakanaDbService.loadData();
      katakanaData.value = katakanaModel;
    } catch (e) {
      debugPrint("$AppExceptions().failToFetchData: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void onSpeak(String character) async {
    boxColors.remove(selectedWord.value);
    selectedWord.value = character;
    final random = Random();
    boxColors[character] = Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
    await _ttsService.speak(character, targetLanguage.value);
    boxColors[character] = AppColors.container(Get.context!);
  }

  Color getBoxColor(String character) {
    return boxColors[character] ?? AppColors.container(Get.context!);
  }

  @override
  void onClose() {
    _ttsService.stop();
    super.onClose();
  }
}
