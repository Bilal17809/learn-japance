import 'package:get/get.dart';
import '../local_storage/local_storage.dart';
import '/presentation/phrases/controller/phrases_controller.dart';
import '/presentation/translator/controller/translator_controller.dart';
import '/presentation/phrases_topic/controller/phrases_topic_controller.dart';
import '/presentation/grammar/controller/grammar_controller.dart';
import '/presentation/home/controller/home_controller.dart';
import '/presentation/grammar_type/controller/grammar_type_controller.dart';
import '/presentation/splash/controller/splash_controller.dart';
import '../services/services.dart';

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
    Get.lazyPut(() => PhrasesDbService(), fenix: true);
    Get.lazyPut(() => LanguageService(), fenix: true);
    Get.lazyPut(() => GrammarDbService(), fenix: true);

    /// Controllers
    Get.lazyPut<SplashController>(() => SplashController());

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
      return PhrasesController(
        dbService: phrasesService,
        translationService: translationService,
      );
    }, fenix: true);
    Get.lazyPut<TranslatorController>(() {
      final lngService = Get.find<LanguageService>();
      final translationService = Get.find<TranslationService>();
      final storageService = Get.find<TranslatorStorageService>();
      final speechService = Get.find<SpeechService>();
      return TranslatorController(
        lngService: lngService,
        translationService: translationService,
        speechService: speechService,
        storageService: storageService,
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
