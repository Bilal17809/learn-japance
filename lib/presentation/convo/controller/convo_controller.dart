import 'package:get/get.dart';
import '/core/common/app_exceptions.dart';
import '/core/services/services.dart';

class ConvoController extends GetxController {
  final TranslationService _translationService;

  ConvoController({required TranslationService translationService})
    : _translationService = translationService;

  var titles = <String>[].obs;
  var conversations = <String>[].obs;
  final RxMap<String, String> translationCache = <String, String>{}.obs;
  final RxMap<String, bool> translatingStates = <String, bool>{}.obs;
  var showTranslation = false.obs;
  var translatedCategory = ''.obs;

  void setArgs({
    required List<String> titles,
    required List<String> conversations,
  }) {
    this.titles.assignAll(titles);
    this.conversations.assignAll(conversations);
  }

  Future<void> translateText(String key, String text) async {
    if (translationCache.containsKey(key)) return;

    translatingStates[key] = true;
    try {
      final translation = await _translationService.translateText(
        text,
        targetLanguage: 'ja',
      );
      translationCache[key] = translation;
    } catch (e) {
      translationCache[key] = "${AppExceptions().failToTranslate}: $e";
    } finally {
      translatingStates[key] = false;
    }
  }

  Future<void> translateConversation(int index) async {
    final titleKey = "title_$index";
    final convoKey = "convo_$index";

    await Future.wait([
      translateText(titleKey, titles[index]),
      translateText(convoKey, conversations[index]),
    ]);
  }

  void toggleTranslationVisibility() {
    showTranslation.value = !showTranslation.value;
  }
}
