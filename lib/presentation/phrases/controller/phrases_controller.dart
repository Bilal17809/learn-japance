import 'package:get/get.dart';
import '/core/services/phrases_db_service.dart';
import '/core/services/translation_service.dart';
import '/data/models/models.dart';

class PhrasesController extends GetxController {
  final PhrasesDbService _dbService = Get.find<PhrasesDbService>();
  final TranslationService translationService = TranslationService();

  var phrases = <PhrasesModel>[].obs;
  var isLoading = true.obs;
  var error = ''.obs;

  final RxMap<String, String> translationCache = <String, String>{}.obs;
  final RxMap<String, bool> translatingStates = <String, bool>{}.obs;

  var topicId = 0.obs;
  var translatedDescription = ''.obs;
  var showTranslation = false.obs;

  void setTopic(int id, String description) {
    topicId.value = id;
    fetchPhrases();
    translateDescription(description);
  }

  void toggleTranslationVisibility() {
    showTranslation.value = !showTranslation.value;
  }

  Future<void> fetchPhrases() async {
    isLoading.value = true;
    try {
      await Future.delayed(const Duration(milliseconds: 350));
      error.value = '';
      final data = await _dbService.getPhrasesByTopic(topicId.value);
      phrases.assignAll(data);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> translateText(String key, String text) async {
    if (translationCache.containsKey(key)) return;
    translatingStates[key] = true;
    try {
      final translation = await translationService.translateText(
        text,
        targetLanguage: 'ja',
      );
      translationCache[key] = translation;
    } catch (e) {
      translationCache[key] = "Translation failed";
    } finally {
      translatingStates[key] = false;
    }
  }

  Future<void> translateAll(PhrasesModel item) async {
    final textsToTranslate = [item.explanation, item.sentence];
    final translations = await translationService.translateList(
      textsToTranslate,
      targetLanguage: 'ja',
    );

    await translateText("${item.id}_explanation", translations[0]);
    await translateText("${item.id}_sentence", translations[1]);
  }

  Future<void> translateDescription(String description) async {
    translatedDescription.value = "翻訳中...";
    try {
      final translation = await translationService.translateText(
        description,
        targetLanguage: 'ja',
      );
      translatedDescription.value = translation;
    } catch (e) {
      translatedDescription.value = "Translation failed";
    }
  }
}
