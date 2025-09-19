import 'dart:io';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '/core/common/app_exceptions.dart';
import 'ad_manager.dart';

class AppOpenAdManager extends GetxController with WidgetsBindingObserver {
  AppOpenAd? _appOpenAd;
  final RemoveAds removeAds = Get.find<RemoveAds>();
  final RxBool isAdVisible = false.obs;
  bool _isAdAvailable = false;
  bool shouldShowAppOpenAd = true;
  bool isCooldownActive = false;
  bool _interstitialAdDismissed = false;
  bool _openAppAdEligible = false;
  bool isAppResumed = false;
  bool _isSplashInterstitialShown = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _openAppAdEligible = true;
    } else if (state == AppLifecycleState.resumed) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (_openAppAdEligible && !_interstitialAdDismissed) {
          showAdIfAvailable();
        } else {
          debugPrint("!!!!!!!!!!!!Skipping Open App Ad");
        }
        _openAppAdEligible = false;
        _interstitialAdDismissed = false;
      });
    }
  }

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    _initRemoteConfig();
  }

  Future<void> _initRemoteConfig() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    try {
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(minutes: 1),
      );
      String appOpenKey;
      if (Platform.isAndroid) {
        appOpenKey = 'AppOpenAd';
      } else if (Platform.isIOS) {
        appOpenKey = 'AppOpenAd';
      } else {
        throw UnsupportedError(AppExceptions().unsupportedPlatform);
      }
      await remoteConfig.fetchAndActivate();
      final showAd = remoteConfig.getBool(appOpenKey);
      if (showAd) {
        loadAd();
      }
    } catch (e) {
      debugPrint('${AppExceptions().remoteConfigError}: $e');
    }
  }

  void showAdIfAvailable() {
    if (removeAds.isSubscribedGet.value) {
      return;
    }
    if (_isAdAvailable && _appOpenAd != null && !isCooldownActive) {
      _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (ad) {
          isAdVisible.value = true;
        },
        onAdDismissedFullScreenContent: (ad) {
          _appOpenAd = null;
          _isAdAvailable = false;
          isAdVisible.value = false;
          loadAd();
          activateCooldown();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          _appOpenAd = null;
          _isAdAvailable = false;
          isAdVisible.value = false;
          loadAd();
        },
      );
      _appOpenAd!.show();
      _appOpenAd = null;
      _isAdAvailable = false;
    } else {
      loadAd();
    }
  }

  void activateCooldown() {
    isCooldownActive = true;
    Future.delayed(const Duration(seconds: 5), () {
      isCooldownActive = false;
    });
  }

  void loadAd() {
    if (Platform.isIOS && removeAds.isSubscribedGet.value) {
      return;
    }
    if (!shouldShowAppOpenAd) return;
    AppOpenAd.load(
      adUnitId: _getAdUnitId(),
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenAd = ad;
          _isAdAvailable = true;
        },
        onAdFailedToLoad: (error) {
          _isAdAvailable = false;
        },
      ),
    );
  }

  void setInterstitialAdDismissed() {
    _interstitialAdDismissed = true;
  }

  void setSplashInterstitialFlag(bool shown) {
    _isSplashInterstitialShown = shown;
  }

  void maybeShowAppOpenAd() {
    if (_isSplashInterstitialShown) {
      return;
    }
  }

  String _getAdUnitId() {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/9257395921'; // Test Id
    } else if (Platform.isIOS) {
      return '';
    } else {
      throw UnsupportedError('Platform not supported');
    }
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    _appOpenAd?.dispose();
    super.onClose();
  }
}
