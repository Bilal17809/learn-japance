import 'package:get/get.dart';
import 'package:learn_japan/presentation/jlpt_kanji/controller/jlpt_kanji_controller.dart';
import '/presentation/characters/controller/characters_controller.dart';
import '/presentation/dictionary/controller/dictionary_controller.dart';
import '/presentation/learn/controller/learn_controller.dart';
import '/presentation/learn_category/controller/learn_category_controller.dart';
import '/core/helper/helper.dart';
import '/presentation/conversation/controller/conversation_controller.dart';
import '/presentation/conversation_category/controller/conversation_category_controller.dart';
import '/core/local_storage/local_storage.dart';
import '/presentation/phrases/controller/phrases_controller.dart';
import '/presentation/translator/controller/translator_controller.dart';
import '/presentation/phrases_topic/controller/phrases_topic_controller.dart';
import '/presentation/grammar/controller/grammar_controller.dart';
import '/presentation/home/controller/home_controller.dart';
import '/presentation/grammar_type/controller/grammar_type_controller.dart';
import '/presentation/splash/controller/splash_controller.dart';
import '/core/services/services.dart';

class DependencyInjection {
  static void init() {
    /// Core Services
    Get.lazyPut(() => LocalStorage(), fenix: true);
    Get.lazyPut(() => TranslationService(), fenix: true);
    Get.lazyPut(() => TtsService(), fenix: true);
    Get.lazyPut(() => SpeechService(), fenix: true);
    Get.lazyPut(
      () => TranslatorStorageService(localStorage: Get.find<LocalStorage>()),
      fenix: true,
    );
    Get.lazyPut(() => AiService(), fenix: true);
    Get.lazyPut(() => DbHelper(), fenix: true);
    Get.lazyPut(() {
      final dbHelper = Get.find<DbHelper>();
      return PhrasesDbService(dbHelper: dbHelper);
    }, fenix: true);
    Get.lazyPut(() {
      return ConversationDbService();
    }, fenix: true);
    Get.lazyPut(() {
      final dbHelper = Get.find<DbHelper>();
      return LearnDbService(dbHelper: dbHelper);
    }, fenix: true);
    Get.lazyPut(() {
      final dbHelper = Get.find<DbHelper>();
      return DictionaryDbService(dbHelper: dbHelper);
    }, fenix: true);
    Get.lazyPut(() => HiraganaDbService(), fenix: true);
    Get.lazyPut(() => KatakanaDbService(), fenix: true);
    Get.lazyPut(() => KanjiDbService(), fenix: true);
    Get.lazyPut(() => LanguageService(), fenix: true);
    Get.lazyPut(() => GrammarDbService(), fenix: true);
    Get.lazyPut(() {
      final dbHelper = Get.find<DbHelper>();
      return OnCloseService(dbHelper: dbHelper);
    }, fenix: true);

    /// Controllers
    Get.lazyPut<SplashController>(() {
      final dbHelper = Get.find<DbHelper>();
      return SplashController(dbHelper: dbHelper);
    }, fenix: true);

    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut<PhrasesTopicController>(() {
      final phrasesService = Get.find<PhrasesDbService>();
      final translationService = Get.find<TranslationService>();
      final localStorage = Get.find<LocalStorage>();
      return PhrasesTopicController(
        phrasesDbService: phrasesService,
        translationService: translationService,
        localStorage: localStorage,
      );
    }, fenix: true);
    Get.lazyPut<PhrasesController>(() {
      final phrasesService = Get.find<PhrasesDbService>();
      final translationService = Get.find<TranslationService>();
      final localStorage = Get.find<LocalStorage>();
      return PhrasesController(
        dbService: phrasesService,
        translationService: translationService,
        localStorage: localStorage,
      );
    }, fenix: true);
    Get.lazyPut<TranslatorController>(() {
      final languageService = Get.find<LanguageService>();
      final translationService = Get.find<TranslationService>();
      final storageService = Get.find<TranslatorStorageService>();
      final speechService = Get.find<SpeechService>();
      return TranslatorController(
        languageService: languageService,
        translationService: translationService,
        speechService: speechService,
        storageService: storageService,
      );
    }, fenix: true);
    Get.lazyPut<ConversationCategoryController>(() {
      final conversationDbService = Get.find<ConversationDbService>();
      return ConversationCategoryController(
        conversationDbService: conversationDbService,
      );
    }, fenix: true);

    Get.lazyPut<ConversationController>(() {
      final ttsService = Get.find<TtsService>();
      return ConversationController(ttsService: ttsService);
    }, fenix: true);
    Get.lazyPut(() {
      final learnDbService = Get.find<LearnDbService>();
      return LearnCategoryController(learnDbService: learnDbService);
    }, fenix: true);
    Get.lazyPut(() {
      final learnDbService = Get.find<LearnDbService>();
      final ttsService = Get.find<TtsService>();
      return LearnController(
        learnDbService: learnDbService,
        ttsService: ttsService,
      );
    }, fenix: true);
    Get.lazyPut(() {
      final dictionaryDbService = Get.find<DictionaryDbService>();
      final ttsService = Get.find<TtsService>();
      final aiService = Get.find<AiService>();
      return DictionaryController(
        dictionaryDbService: dictionaryDbService,
        ttsService: ttsService,
        aiService: aiService,
      );
    }, fenix: true);
    Get.lazyPut(() {
      final hiraganaDbService = Get.find<HiraganaDbService>();
      final katakanaDbService = Get.find<KatakanaDbService>();
      final ttsService = Get.find<TtsService>();
      return CharactersController(
        hiraganaDbService: hiraganaDbService,
        katakanaDbService: katakanaDbService,
        ttsService: ttsService,
      );
    }, fenix: true);
    Get.lazyPut(() {
      final ttsService = Get.find<TtsService>();
      final kanjiDbService = Get.find<KanjiDbService>();
      return JlptKanjiController(
        ttsService: ttsService,
        kanjiDbService: kanjiDbService,
      );
    }, fenix: true);
    Get.lazyPut<GrammarTypeController>(() {
      final grammarDbService = Get.find<GrammarDbService>();
      final translationService = Get.find<TranslationService>();
      return GrammarTypeController(
        grammarDbService: grammarDbService,
        translationService: translationService,
      );
    }, fenix: true);
    Get.lazyPut<GrammarController>(() {
      final grammarDbService = Get.find<GrammarDbService>();
      final translationService = Get.find<TranslationService>();
      return GrammarController(
        grammarDbService: grammarDbService,
        translationService: translationService,
      );
    }, fenix: true);
  }
}
