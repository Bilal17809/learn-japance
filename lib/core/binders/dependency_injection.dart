import 'package:get/get.dart';
import '/presentation/grammar/controller/grammar_controller.dart';
import '/presentation/home/controller/home_controller.dart';
import '/presentation/grammar_type/controller/grammar_type_controller.dart';
import '/presentation/splash/controller/splash_controller.dart';
import '../services/services.dart';

class DependencyInjection {
  static void init() {
    /// Core Services
    Get.lazyPut(() => GrammarService(), fenix: true);

    /// Controllers
    Get.lazyPut(() => SplashController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => GrammarTypeController(), fenix: true);
    Get.lazyPut(() => GrammarController(), fenix: true);
  }
}
