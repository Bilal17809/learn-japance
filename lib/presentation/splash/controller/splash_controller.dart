import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/ad_manager/ad_manager.dart';
import '/core/utils/utils.dart';
import '/core/helper/helper.dart';

class SplashController extends GetxController {
  final DbHelper _dbHelper;
  final _isLoading = true.obs;
  var showButton = false.obs;

  SplashController({required DbHelper dbHelper}) : _dbHelper = dbHelper;

  @override
  void onReady() {
    super.onReady();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<SplashInterstitialManager>().loadAd();
    });
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
}
