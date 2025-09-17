import 'dart:io';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:learn_japan/core/theme/theme.dart';
import 'package:shimmer/shimmer.dart';
import '/core/common/app_exceptions.dart';
import 'ad_manager.dart';

class BannerAdController extends GetxController {
  BannerAd? _bannerAd;
  var isAdLoaded = false.obs;
  var isAdEnabled = true.obs;

  final removeAds = Get.find<RemoveAds>();
  final appOpenAdManager = Get.find<AppOpenAdManager>();

  @override
  void onInit() {
    super.onInit();
    _initRemoteConfig();
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

      String bannerAdKey;
      if (Platform.isAndroid) {
        bannerAdKey = '';
      } else if (Platform.isIOS) {
        bannerAdKey = 'BannerAd_ios';
      } else {
        throw UnsupportedError(AppExceptions().unsupportedPlatform);
      }
      await remoteConfig.fetchAndActivate();
      isAdEnabled.value = remoteConfig.getBool(bannerAdKey);
      if (isAdEnabled.value) {
        loadBannerAd();
      }
    } catch (e) {
      debugPrint('${AppExceptions().remoteConfigError}: $e');
      isAdEnabled.value = false;
    }
  }

  Future<void> loadBannerAd() async {
    final context = Get.context;
    if (context == null) return;
    AdSize? adSize =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
          MediaQuery.of(context).size.width.truncate(),
        );

    _bannerAd = BannerAd(
      adUnitId: _adUnitId,
      size: adSize!,
      request: const AdRequest(extras: {'collapsible': 'bottom'}),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          isAdLoaded.value = true;
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('!!!!!!!! Banner Ad failed: ${error.message}');
          isAdLoaded.value = false;
          ad.dispose();
        },
      ),
    )..load();
  }

  BannerAd? get bannerAd => _bannerAd;

  String get _adUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/9214589741';
    } else if (Platform.isIOS) {
      return '';
    } else {
      throw UnsupportedError(AppExceptions().unsupportedPlatform);
    }
  }

  @override
  void onClose() {
    _bannerAd?.dispose();
    super.onClose();
  }
}

class BannerAdWidget extends StatelessWidget {
  const BannerAdWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bannerAdController = Get.put(BannerAdController());

    return Obx(() {
      if (!bannerAdController.isAdEnabled.value ||
          bannerAdController.removeAds.isSubscribedGet.value ||
          bannerAdController.appOpenAdManager.isAdVisible.value) {
        return const SizedBox();
      }

      return bannerAdController.isAdLoaded.value &&
              bannerAdController.bannerAd != null
          ? SafeArea(
            child: Container(
              margin: const EdgeInsets.all(2.0),
              padding: const EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300, width: 1.2),
                borderRadius: BorderRadius.circular(2.0),
              ),
              width: bannerAdController.bannerAd!.size.width.toDouble(),
              height: bannerAdController.bannerAd!.size.height.toDouble(),
              child: AdWidget(ad: bannerAdController.bannerAd!),
            ),
          )
          : SafeArea(
            top: false,
            bottom: true,
            left: false,
            right: false,
            child: Shimmer.fromColors(
              baseColor: AppColors().getBgColor(context),
              highlightColor: Colors.black87,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
          );
    });
  }
}
