import 'dart:async';
import 'package:get/get.dart';
import '/ad_manager/ad_manager.dart';
import '/core/utils/utils.dart';
import '/core/helper/helper.dart';

class SplashController extends GetxController {
  final DbHelper _dbHelper;
  final _isLoading = true.obs;
  var showButton = false.obs;
  var visibleLetters = 0.obs;
  var fadeInOut = true.obs;
  final String titleText = "Japanese made simple";
  Timer? _typewriterTimer;
  SplashController({required DbHelper dbHelper}) : _dbHelper = dbHelper;

  @override
  void onInit() {
    super.onInit();
    _startTypewriter();
    Get.find<SplashInterstitialManager>().loadAd();
    _init();
  }

  void _init() async {
    try {
      _isLoading.value = true;
      await Future.delayed(const Duration(seconds: 4));
      await _dbHelper.initDatabase('phrases_db', Assets.phrasesDb);
      await _dbHelper.initDatabase('learn_japanese', Assets.learnDb);
      await _dbHelper.initDatabase('dictionary_db', Assets.dictDb);
    } finally {
      _isLoading.value = false;
      showButton.value = true;
    }
  }

  void _startTypewriter() {
    _typewriterTimer?.cancel();
    _typewriterTimer = Timer.periodic(const Duration(milliseconds: 100), (
      timer,
    ) {
      if (visibleLetters.value < titleText.length) {
        visibleLetters.value++;
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void onClose() {
    _typewriterTimer?.cancel();
    super.onClose();
  }
}
