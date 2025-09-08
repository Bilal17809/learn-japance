import 'package:get/get.dart';
import '/core/local_storage/local_storage.dart';
import '/core/common/app_exceptions.dart';
import '/core/services/services.dart';
import '/data/models/models.dart';

class PhrasesController extends GetxController {
  final PhrasesDbService _dbService;
  final TranslationService _translationService;
  final LocalStorage _localStorage;
  var phrases = <PhrasesModel>[].obs;
  final RxMap<String, String> translationCache = <String, String>{}.obs;
  final RxMap<String, bool> translatingStates = <String, bool>{}.obs;
  final _topicId = 0.obs;
  var translatedDescription = ''.obs;
  var showTranslation = false.obs;
  var isLoading = true.obs;
  final _error = ''.obs;

  PhrasesController({
    required PhrasesDbService dbService,
    required TranslationService translationService,
    required LocalStorage localStorage,
  }) : _dbService = dbService,
       _translationService = translationService,
       _localStorage = localStorage;

  @override
  void onInit() {
    super.onInit();
    _initTranslations();
  }

  Future<void> _initTranslations() async {
    if (_topicId.value != 0) {
      await fetchPhrases();
    }
  }

  void setTopic(int id, String description) async {
    _topicId.value = id;
    await fetchPhrases();
    await translateDescription(description);
  }

  void toggleTranslationVisibility() {
    showTranslation.value = !showTranslation.value;
  }

  Future<void> fetchPhrases() async {
    isLoading.value = true;
    try {
      await Future.delayed(const Duration(milliseconds: 140));
      _error.value = '';
      final data = await _dbService.getPhrasesByTopic(_topicId.value);
      phrases.assignAll(data);
      await translateAll();
    } catch (e) {
      _error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> translateItem(PhrasesModel item) async {
    final explanationKey = "translation_${item.id}_explanation";
    final sentenceKey = "translation_${item.id}_sentence";
    try {
      if (translationCache.containsKey(explanationKey) &&
          translationCache.containsKey(sentenceKey)) {
        return;
      }

      final savedExplanation = await _localStorage.getString(explanationKey);
      final savedSentence = await _localStorage.getString(sentenceKey);

      if (savedExplanation != null && savedSentence != null) {
        translationCache[explanationKey] = savedExplanation;
        translationCache[sentenceKey] = savedSentence;
        return;
      }

      final textsToTranslate = [item.explanation, item.sentence];
      final translations = await _translationService.translateList(
        textsToTranslate,
        targetLanguage: 'ja',
      );

      translationCache["${item.id}_explanation"] = translations[0];
      translationCache["${item.id}_sentence"] = translations[1];
    } catch (e) {
      translationCache["${item.id}_explanation"] =
          "${AppExceptions().failToTranslate}: $e";
      translationCache["${item.id}_sentence"] =
          "${AppExceptions().failToTranslate}: $e";
    }
  }

  Future<void> translateAll() async {
    await Future.wait(phrases.map(translateItem));
  }

  Future<void> translateDescription(String description) async {
    final descKey = "translation_topic_${_topicId.value}_description";

    translatedDescription.value = "翻訳中...";
    try {
      final savedDesc = await _localStorage.getString(descKey);
      if (savedDesc != null) {
        translatedDescription.value = savedDesc;
        return;
      }
      final translation = await _translationService.translateText(
        description,
        targetLanguage: 'ja',
      );
      translatedDescription.value = translation;
      await _localStorage.setString(descKey, translation);
    } catch (e) {
      translatedDescription.value = "${AppExceptions().failToTranslate}: $e";
    }
  }
}
