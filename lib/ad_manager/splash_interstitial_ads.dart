import 'dart:io';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '/core/common/app_exceptions.dart';
import 'ad_manager.dart';

class SplashInterstitialManager extends GetxController {
  InterstitialAd? _splashAd;
  bool isAdReady = false;
  var isShowing = false.obs;
  bool displaySplashAd = true;
  final removeAds = Get.find<RemoveAds>();
  final appOpenAdManager = Get.find<AppOpenAdManager>();

  @override
  void onInit() {
    super.onInit();
    _initRemoteConfig();
    loadAd();
  }

  Future<void> _initRemoteConfig() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    try {
      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: const Duration(seconds: 1),
        ),
      );
      String splashAdKey;
      if (Platform.isAndroid) {
        splashAdKey = '';
      } else if (Platform.isIOS) {
        splashAdKey = '';
      } else {
        throw UnsupportedError(AppExceptions().unsupportedPlatform);
      }
      await remoteConfig.fetchAndActivate();
      displaySplashAd = remoteConfig.getBool(splashAdKey);
      loadAd();
      update();
    } catch (e) {
      debugPrint('${AppExceptions().remoteConfigError}: $e');
      displaySplashAd = false;
    }
  }

  void loadAd() {
    InterstitialAd.load(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _splashAd = ad;
          isAdReady = true;
        },
        onAdFailedToLoad: (error) {
          isAdReady = false;
          debugPrint(
            '!!!!!!!!!!!!Splash InterstitialAd failed to load: $error',
          );
        },
      ),
    );
  }

  void showSplashAd(VoidCallback onAdClosed) {
    if (!isAdReady || removeAds.isSubscribedGet.value) {
      debugPrint('!!!!!!!!!!Splash InterstitialAd not ready');
      onAdClosed();
      return;
    }
    isShowing.value = true;
    _splashAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        appOpenAdManager.setInterstitialAdDismissed();
        ad.dispose();
        isShowing.value = false;
        onAdClosed();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        debugPrint("Splash Interstitial failed: $error");
        appOpenAdManager.setInterstitialAdDismissed();
        ad.dispose();
        isShowing.value = false;
        _resetAfterAd();
        onAdClosed();
      },
    );
    _splashAd!.show();
    _splashAd = null;
    isAdReady = false;
  }

  void _resetAfterAd() {
    isAdReady = false;
    loadAd();
    update();
  }

  String get _adUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/1033173712';
    } else if (Platform.isIOS) {
      return '';
    } else {
      throw UnsupportedError("Platform not supported");
    }
  }

  @override
  void onClose() {
    _splashAd?.dispose();
    super.onClose();
  }
}
