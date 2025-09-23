import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/utils/utils.dart';
import '/presentation/splash/controller/splash_controller.dart';
import '/ad_manager/ad_manager.dart';
import '/core/constants/constants.dart';
import '/core/theme/theme.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '/presentation/home/view/home_view.dart';
import 'package:slide_to_act/slide_to_act.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SplashController>();
    final splashAd = Get.find<SplashInterstitialManager>();
    return Scaffold(
      backgroundColor: AppColors.lightBgColor,
      body: Obx(() {
        final visibleText = controller.titleText.substring(
          0,
          controller.visibleLetters.value,
        );
        return Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.splashContainer),
                  fit: BoxFit.fill,
                ),
              ),
              child: SafeArea(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                      child: Image.asset(Assets.splashGlow),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 76, 40, 40),
                      child: Image.asset(Assets.kids),
                    ),
                    Positioned(
                      top: kBodyHp * 1.4,
                      left: kGap,
                      right: kGap,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          visibleText,
                          style: headlineMediumStyle.copyWith(
                            fontSize: 38,
                            color: AppColors.primaryColorLight,
                            shadows: kShadow,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: context.screenHeight * 0.12,
                      left: context.screenWidth * 0.36,
                      right: context.screenWidth * 0.26,
                      child: Column(
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'Learn Japanese',
                              style: titleLargeStyle.copyWith(
                                fontSize: context.screenWidth * 0.06,
                                color: AppColors.primaryColorLight,
                                shadows: kShadow,
                              ),
                            ),
                          ),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              '日本語を学ぶ',
                              style: titleLargeStyle.copyWith(
                                fontSize: context.screenWidth * 0.06,
                                color: AppColors.primaryColorLight,
                                shadows: kShadow,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(kBodyHp),
                child: Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(seconds: 1),
                    child:
                        controller.showButton.value
                            ? AnimatedOpacity(
                              opacity: controller.showButton.value ? 1.0 : 0.0,
                              duration: const Duration(milliseconds: 600),
                              child: SizedBox(
                                width: context.screenWidth * 0.7,
                                child: SlideAction(
                                  borderRadius: kCircularBorderRadius,
                                  elevation: 0,
                                  height: 56,
                                  sliderButtonIconSize: kCircularBorderRadius,
                                  sliderButtonYOffset: -kGap,
                                  sliderRotate: false,
                                  sliderButtonIcon: const Icon(
                                    Icons.double_arrow_rounded,
                                    color: AppColors.primaryColorLight,
                                  ),
                                  innerColor: AppColors.kWhite,
                                  outerColor: AppColors.primaryColorLight,
                                  text: 'Slide to Start',
                                  textStyle: titleLargeStyle.copyWith(
                                    color: AppColors.kWhite,
                                    shadows: kShadow,
                                  ),
                                  onSubmit: () async {
                                    if (splashAd.isAdReady) {
                                      splashAd.showSplashAd();
                                      Get.to(() => HomeView());
                                    } else {
                                      Get.to(() => HomeView());
                                    }
                                  },
                                ),
                              ),
                            )
                            : LoadingAnimationWidget.halfTriangleDot(
                              color: AppColors.primaryColorLight,
                              size: context.screenWidth * 0.14,
                            ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
