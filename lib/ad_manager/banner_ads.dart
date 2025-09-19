import 'dart:io';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shimmer/shimmer.dart';
import 'ad_manager.dart';

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({super.key});

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  BannerAd? _bannerAd;
  bool _isAdLoaded = false;
  bool _isAdEnabled = true;

  final removeAds = Get.find<RemoveAds>();

  @override
  void initState() {
    super.initState();
    _initRemoteConfig();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadBannerAd();
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
      String bannerAdKey;
      if (Platform.isAndroid) {
        bannerAdKey = 'banner';
      } else if (Platform.isIOS) {
        bannerAdKey = 'BannerAd';
      } else {
        throw UnsupportedError('Platform not supported');
      }
      await remoteConfig.fetchAndActivate();
      final showBanner = remoteConfig.getBool(bannerAdKey);
      if (!mounted) return;
      setState(() => _isAdEnabled = showBanner);
      if (showBanner) {
        loadBannerAd();
      }
    } catch (e) {
      debugPrint('Error initializing remote config: $e');
    }
  }

  void loadBannerAd() async {
    AdSize? adSize =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
          MediaQuery.sizeOf(Get.context!).width.truncate(),
        );
    _bannerAd = BannerAd(
      adUnitId:
          Platform.isAndroid
              ? 'ca-app-pub-3940256099942544/6300978111' // Test Id
              // ? ''
              : '',
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          debugPrint("!!!!!!!!!!! BannerAd loaded: ${ad.adUnitId}");
          setState(() => _isAdLoaded = true);
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('!!!!!!!!!!!!!!!!!! Banner Ad failed: ${error.message}');
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appOpenAdController = Get.find<AppOpenAdManager>();
    return Obx(() {
      if (!_isAdEnabled ||
          removeAds.isSubscribedGet.value ||
          appOpenAdController.isAdVisible.value) {
        return const SizedBox();
      }
      return _isAdLoaded && _bannerAd != null
          ? SafeArea(
            child: Container(
              margin: const EdgeInsets.all(2.0),
              padding: const EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300, width: 1.2),
                borderRadius: BorderRadius.circular(2.0),
              ),
              width: _bannerAd!.size.width.toDouble(),
              height: _bannerAd!.size.height.toDouble(),
              child: AdWidget(ad: _bannerAd!),
            ),
          )
          : SafeArea(
            top: false,
            bottom: true,
            left: false,
            right: false,
            child: Shimmer.fromColors(
              baseColor: Colors.white,
              highlightColor: Colors.white54,
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
