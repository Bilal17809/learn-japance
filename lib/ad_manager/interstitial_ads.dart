import 'dart:io';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '/core/common/app_exceptions.dart';
import 'ad_manager.dart';

class InterstitialAdManager extends GetxController {
  final removeAds = Get.find<RemoveAds>();
  final appOpenAdManager = Get.find<AppOpenAdManager>();
  InterstitialAd? _currentAd;
  bool isAdReady = false;
  var isShow = false.obs;
  int visitCounter = 0;
  late int displayThreshold;

  @override
  void onInit() {
    super.onInit();
    displayThreshold = 3;
    _initRemoteConfig();
    _loadAd();
  }

  Future<void> _initRemoteConfig() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    try {
      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: const Duration(minutes: 1),
        ),
      );
      String interstitialKey;
      if (Platform.isAndroid) {
        interstitialKey = 'InterstitialAd';
      } else if (Platform.isIOS) {
        interstitialKey = '';
      } else {
        throw UnsupportedError(AppExceptions().unsupportedPlatform);
      }
      await remoteConfig.fetchAndActivate();
      final newThreshold = remoteConfig.getInt(interstitialKey);
      if (newThreshold > 0) {
        displayThreshold = newThreshold;
      }
    } catch (e) {
      debugPrint('${AppExceptions().remoteConfigError}: $e');
    }
  }

  void _loadAd() {
    InterstitialAd.load(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _currentAd = ad;
          isAdReady = true;
          update();
        },
        onAdFailedToLoad: (error) {
          isAdReady = false;
          debugPrint("!!!!!!!!!!!!!!!!!!! Interstitial load error: $error");
        },
      ),
    );
  }

  void _showAd() {
    if (removeAds.isSubscribedGet.value) {
      const SizedBox();
    }
    if (_currentAd == null) return;
    isShow.value = true;
    _currentAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        appOpenAdManager.setInterstitialAdDismissed();
        ad.dispose();
        isShow.value = false;
        _resetAfterAd();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        debugPrint("!!!!!!!!!!!! Interstitial failed: $error");
        appOpenAdManager.setInterstitialAdDismissed();
        ad.dispose();
        isShow.value = false;
        _resetAfterAd();
      },
    );
    _currentAd!.show();
    _currentAd = null;
    isAdReady = false;
  }

  void checkAndDisplayAd() {
    visitCounter++;
    debugPrint("!!!!!!!!!!! Visit count: $visitCounter");
    if (visitCounter >= displayThreshold) {
      if (isAdReady) {
        _showAd();
      } else {
        debugPrint("Interstitial not ready yet.");
        visitCounter = 0;
      }
    }
  }

  void _resetAfterAd() {
    visitCounter = 0;
    isAdReady = false;
    _loadAd();
    update();
  }

  String get _adUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-8331781061822056/4187628497';
      // return 'ca-app-pub-3940256099942544/1033173712'; // testId
    } else if (Platform.isIOS) {
      return '';
    } else {
      throw UnsupportedError("Platform not supported");
    }
  }

  @override
  void onClose() {
    _currentAd?.dispose();
    super.onClose();
  }
}
