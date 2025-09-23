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
      final key = Platform.isAndroid ? 'NativeAdvAd' : '';
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
        Platform.isAndroid
            // ? 'ca-app-pub-3940256099942544/2247696110'
            ? 'ca-app-pub-8331781061822056/2104390636'
            : '';

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
      highlightColor: AppColors.container(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.primary(context).withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.primary(context).withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.primary(context).withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 12,
                      width: width * 0.4,
                      decoration: BoxDecoration(
                        color: AppColors.primary(
                          context,
                        ).withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 10,
                      width: width * 0.25,
                      decoration: BoxDecoration(
                        color: AppColors.primary(
                          context,
                        ).withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 10,
                      width: width * 0.25,
                      decoration: BoxDecoration(
                        color: AppColors.primary(
                          context,
                        ).withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 12,
                      width: width * 0.4,
                      decoration: BoxDecoration(
                        color: AppColors.primary(
                          context,
                        ).withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                height: 30,
                width: 70,
                decoration: BoxDecoration(
                  color: AppColors.primary(context).withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget shimmerMediumWidget(double width) {
    return Shimmer.fromColors(
      baseColor: AppColors.secondary(context),
      highlightColor: AppColors.container(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.primary(context).withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.primary(context).withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 180,
                width: width,
                decoration: BoxDecoration(
                  color: AppColors.primary(context).withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                height: 14,
                width: width * 0.6,
                decoration: BoxDecoration(
                  color: AppColors.primary(context).withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 12,
                width: width * 0.8,
                decoration: BoxDecoration(
                  color: AppColors.primary(context).withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: 36,
                  width: 100,
                  decoration: BoxDecoration(
                    color: AppColors.primary(context).withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
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
