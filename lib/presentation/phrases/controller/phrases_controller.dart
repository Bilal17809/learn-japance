import 'package:get/get.dart';
import '/core/mixins/connectivity_mixin.dart';
import '/presentation/home/controller/home_controller.dart';
import '/core/local_storage/local_storage.dart';
import '/core/common/app_exceptions.dart';
import '/core/services/services.dart';
import '/data/models/models.dart';

class PhrasesController extends GetxController with ConnectivityMixin {
  final PhrasesDbService _dbService;
  final TranslationService _translationService;
  final LocalStorage _localStorage;
  final TtsService _ttsService;

  var phrases = <PhrasesModel>[].obs;
  final RxMap<String, String> translationCache = <String, String>{}.obs;
  final RxMap<String, bool> translatingStates = <String, bool>{}.obs;
  var translatedDescription = ''.obs;
  var learnedPhrases = <int, bool>{}.obs;
  final targetLanguage = Rx<LanguageModel>(
    LanguageModel(name: 'Japanese', code: 'ja', ttsCode: 'ja-JP'),
  );
  final _topicId = 0.obs;
  final _error = ''.obs;
  var showTranslation = false.obs;
  var showExplanation = <int, bool>{}.obs;
  var isLoading = true.obs;

  PhrasesController({
    required PhrasesDbService dbService,
    required TranslationService translationService,
    required LocalStorage localStorage,
    required TtsService ttsService,
  }) : _dbService = dbService,
       _translationService = translationService,
       _localStorage = localStorage,
       _ttsService = ttsService;

  @override
  void onReady() {
    super.onReady();
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
    await _translateDescription(description);
  }

  Future<void> fetchPhrases() async {
    isLoading.value = true;
    try {
      await Future.delayed(const Duration(milliseconds: 140));
      _error.value = '';
      final data = await _dbService.getPhrasesByTopic(_topicId.value);
      phrases.assignAll(data);
      await _translateAll();
      await _loadLearnedPhrases();
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
      translationCache[explanationKey] = translations[0];
      translationCache[sentenceKey] = translations[1];
      await _localStorage.setString(explanationKey, translations[0]);
      await _localStorage.setString(sentenceKey, translations[1]);
    } catch (e) {
      translationCache[explanationKey] =
          "${AppExceptions().failToTranslate}: $e";
      translationCache[sentenceKey] = "${AppExceptions().failToTranslate}: $e";
    }
  }

  Future<void> _translateAll() async {
    await Future.wait(phrases.map(translateItem));
  }

  Future<void> _translateDescription(String description) async {
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

  Future<void> _loadLearnedPhrases() async {
    for (var phrase in phrases) {
      final key = "learned_phrase_${phrase.id}";
      final isLearned = await _localStorage.getBool(key) ?? false;
      learnedPhrases[phrase.id] = isLearned;
    }
  }

  Future<void> learnPhrase(int index) async {
    final phrase = phrases[index];
    final key = "learned_phrase_${phrase.id}";

    learnedPhrases[phrase.id] = true;
    await _localStorage.setBool(key, true);
    await Get.find<HomeController>().increaseProgress();
  }

  void onSpeak(String text) {
    _ttsService.speak(text, targetLanguage.value);
  }

  void toggleDescriptionVisibility() {
    showTranslation.value = !showTranslation.value;
  }

  void toggleExplanation(int phraseId) {
    showExplanation[phraseId] = !(showExplanation[phraseId] ?? false);
  }

  @override
  void onClose() {
    _ttsService.onClose();
    super.onClose();
  }
}
