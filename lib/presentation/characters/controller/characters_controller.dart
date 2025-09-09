import 'dart:math';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '/core/theme/theme.dart';
import '/core/services/services.dart';
import '/data/models/models.dart';

class CharactersController extends GetxController {
  final TtsService _ttsService;
  final HiraganaDbService _hiraganaDbService;
  final KatakanaDbService _katakanaDbService;

  var hiraganaData = Rx<HiraganaModel?>(null);
  var katakanaData = Rx<KatakanaModel?>(null);
  var kanjiData = <KanjiModel>[].obs;

  final targetLanguage = Rx<LanguageModel>(
    LanguageModel(name: 'Japanese', code: 'ja', ttsCode: 'ja-JP'),
  );
  var boxColors = <String, Color>{}.obs;
  var isLoading = true.obs;

  CharactersController({
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

  Future<void> _loadAllCharacters() async {
    isLoading.value = true;
    try {
      await Future.delayed(const Duration(milliseconds: 200));
      final hiraganaModel = await _hiraganaDbService.loadData();
      hiraganaData.value = hiraganaModel;
      final katakanaModel = await _katakanaDbService.loadData();
      katakanaData.value = katakanaModel;
    } catch (e) {
      debugPrint("Error loading characters: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void onBoxSpeak(String character) async {
    _changeBoxColor(character);
    await _ttsService.speak(character, targetLanguage.value);
    await Future.delayed(const Duration(milliseconds: 100));
    boxColors[character] = AppColors.container(Get.context!);
  }

  void _changeBoxColor(String character) {
    final random = Random();
    boxColors[character] = Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
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
