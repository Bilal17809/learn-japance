import 'package:get/get.dart';
import 'package:learn_japan/core/services/services.dart';

class SplashController extends GetxController {
  var showButton = false.obs;
  final tts = Get.find<TtsService>();

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() async {
    // await Future.delayed(const Duration(seconds: 1));
    showButton.value = true;
  }
}
