import 'package:get/get.dart';
import 'package:learn_japan/presentation/phrases/controller/phrases_controller.dart';
import '/presentation/phrases_topic/controller/phrases_topic_controller.dart';
import '/presentation/grammar/controller/grammar_controller.dart';
import '/presentation/home/controller/home_controller.dart';
import '/presentation/grammar_type/controller/grammar_type_controller.dart';
import '/presentation/splash/controller/splash_controller.dart';
import '../services/services.dart';
class DependencyInjection {
  static void init() {
    // /// Core Services
    Get.lazyPut(() => PhrasesDbService(), fenix: true);
    Get.lazyPut(() => GrammarDbService(), fenix: true);

    /// Controllers
    Get.lazyPut<SplashController>(() {
      final  dataService = Get.find<GrammarDbService>();
      final phrasesService = Get.find<PhrasesDbService>();
      return SplashController(
        dataService: dataService,
        phrasesDbService: phrasesService
      );
    });


    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => PhrasesTopicController(), fenix: true);
    Get.lazyPut(() => PhrasesController(), fenix: true);
    Get.lazyPut(() => GrammarTypeController(), fenix: true);
    Get.lazyPut(() => GrammarController(), fenix: true);
  }
}

//
// class DependencyInjection {
//   static void init() {
//     /// Core Services
//     Get.lazyPut(() => PhrasesDbService(), fenix: true);
//     Get.lazyPut(() => GrammarDbService(), fenix: true);
//
//     /// Controllers
//     Get.lazyPut(() => SplashController(dataService:, phrasesDbService: ),
//       fenix: true,);
//     Get.lazyPut(() => HomeController(), fenix: true);
//     Get.lazyPut(() => PhrasesTopicController(), fenix: true);
//     Get.lazyPut(() => PhrasesController(), fenix: true);
//     Get.lazyPut(() => GrammarTypeController(), fenix: true);
//     Get.lazyPut(() => GrammarController(), fenix: true);
//   }
// }
