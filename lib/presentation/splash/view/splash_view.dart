import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/presentation/splash/controller/splash_controller.dart';
import '/ad_manager/ad_manager.dart';
import '/core/constants/constants.dart';
import '/core/theme/theme.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '/presentation/home/view/home_view.dart';
import '/core/common_widgets/common_widgets.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SplashController>();
    final splashAd = Get.find<SplashInterstitialManager>();
    return Scaffold(
      body: Obx(() {
        return SafeArea(
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
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: kBodyHp,
                            ),
                            child: SimpleButton(
                              width: context.screenWidth * 0.4,
                              height: 50,
                              backgroundColor: AppColors.primaryColorLight,
                              shadowColor: AppColors.secondaryColorLight,
                              textColor: AppColors.kBlack,
                              onPressed: () async {
                                if (splashAd.isAdReady) {
                                  // splashAd.showSplashAd();
                                  Get.to(() => HomeView());
                                } else {
                                  Get.to(() => HomeView());
                                }
                              },
                              text: "Let's Go",
                            ),
                          ),
                        )
                        : LoadingAnimationWidget.beat(
                          color: AppColors.secondaryColorLight,
                          size: context.screenWidth * 0.2,
                        ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
