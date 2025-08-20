import 'package:get/get.dart';
import 'package:learn_japan/presentation/home/controller/home_controller.dart';
import 'package:learn_japan/presentation/phrases/controller/phrases_controller.dart';
import 'package:learn_japan/presentation/splash/controller/splash_controller.dart';
import '../services/services.dart';

class DependencyInjection {
  static void init() {
    /// Core Services
    Get.lazyPut(() => GrammarService(), fenix: true);

    /// Controllers
    Get.lazyPut(() => SplashController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => PhrasesController(), fenix: true);
  }
}
