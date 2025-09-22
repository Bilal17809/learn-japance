import 'dart:io';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '/core/common/app_exceptions.dart';
import '/core/theme/theme.dart';
import 'ad_manager.dart';
import 'package:shimmer/shimmer.dart';

class NativeAdManager extends GetxController {
  NativeAd? _nativeAd;
  final RxBool isAdReady = false.obs;
  bool showAd = false;
  final TemplateType templateType;

  NativeAdManager({this.templateType = TemplateType.small});

  @override
  void onInit() {
    super.onInit();
    _initRemoteConfig();
  }

  Future<void> _initRemoteConfig() async {
    try {
      final remoteConfig = FirebaseRemoteConfig.instance;

      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 3),
          minimumFetchInterval: const Duration(seconds: 1),
        ),
      );
      await remoteConfig.fetchAndActivate();
      final key = Platform.isAndroid ? 'NativeAdvAd' : 'NativeAdv';
      showAd = remoteConfig.getBool(key);
      if (showAd) {
        loadNativeAd();
      } else {
        debugPrint('!!!!!!!!!!!! Native ad disabled via Remote Config.');
      }
    } catch (e) {
      debugPrint('${AppExceptions().remoteConfigError}: $e');
    }
  }

  void loadNativeAd() {
    isAdReady.value = false;

    final adUnitId =
        Platform.isAndroid ? 'ca-app-pub-3940256099942544/2247696110' : '';

    _nativeAd = NativeAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          _nativeAd = ad as NativeAd;
          isAdReady.value = true;
        },
        onAdFailedToLoad: (ad, error) {
          isAdReady.value = false;
          ad.dispose();
        },
      ),
      nativeTemplateStyle: NativeTemplateStyle(
        mainBackgroundColor: Colors.white,
        templateType: templateType,
      ),
    );

    _nativeAd!.load();
  }

  @override
  void onClose() {
    _nativeAd?.dispose();
    super.onClose();
  }
}

class NativeAdWidget extends StatefulWidget {
  final TemplateType templateType;

  const NativeAdWidget({super.key, this.templateType = TemplateType.small});

  @override
  NativeAdWidgetState createState() => NativeAdWidgetState();
}

class NativeAdWidgetState extends State<NativeAdWidget> {
  late final NativeAdManager _adController;
  late final String _tag;
  final removeAds = Get.find<RemoveAds>();

  @override
  void initState() {
    super.initState();
    _tag = UniqueKey().toString();
    _adController = Get.put(
      NativeAdManager(templateType: widget.templateType),
      tag: _tag,
    );
    _adController.loadNativeAd();
  }

  @override
  void dispose() {
    Get.delete<NativeAdManager>(tag: _tag);
    super.dispose();
  }

  Widget shimmerSmallWidget(double width) {
    return Shimmer.fromColors(
      baseColor: AppColors.secondary(context),
      highlightColor: AppColors.icon(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: AspectRatio(
          aspectRatio: 55 / 15,
          child: Container(
            width: width,
            decoration: BoxDecoration(
              color: AppColors.primary(context),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }

  Widget shimmerMediumWidget(double width) {
    return Shimmer.fromColors(
      baseColor: AppColors.secondary(context),
      highlightColor: AppColors.icon(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                width: width,
                decoration: BoxDecoration(
                  color: AppColors.primary(context),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appOpenAdController = Get.find<AppOpenAdManager>();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final adHeight =
        widget.templateType == TemplateType.medium
            ? screenHeight * 0.48
            : screenHeight * 0.14;

    return Obx(() {
      if (removeAds.isSubscribedGet.value ||
          appOpenAdController.isAdVisible.value) {
        return const SizedBox();
      }
      if (_adController.isAdReady.value && _adController._nativeAd != null) {
        return Container(
          height: adHeight,
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: AdWidget(ad: _adController._nativeAd!),
        );
      } else {
        return SizedBox(
          height: adHeight,
          child:
              widget.templateType == TemplateType.medium
                  ? shimmerMediumWidget(screenWidth)
                  : shimmerSmallWidget(screenWidth),
        );
      }
    });
  }
}
