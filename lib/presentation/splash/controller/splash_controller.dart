import 'package:get/get.dart';
import 'package:learn_japan/core/services/services.dart';

class SplashController extends GetxController {
  var showButton = false.obs;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() async {
    await Future.delayed(const Duration(seconds: 2));
    showButton.value = true;
  }
}
