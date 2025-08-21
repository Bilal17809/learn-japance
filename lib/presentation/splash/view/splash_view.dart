import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_japan/core/constants/constants.dart';
import 'package:learn_japan/core/theme/app_colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../home/view/home_view.dart';
import '/core/common_widgets/common_widgets.dart';
import '../controller/splash_controller.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SplashController>();
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
                              width: mobileWidth(context) * 0.4,
                              height: 50,
                              backgroundColor: AppColors.primaryColorLight,
                              shadowColor: AppColors.secondaryColorLight,
                              textColor: AppColors.kBlack,
                              onPressed: () {
                                // Get.to(() => CategorySelectionScreen());
                                Get.to(() => HomeView());
                              },
                              text: "Let's Go",
                            ),
                          ),
                        )
                        : LoadingAnimationWidget.newtonCradle(
                          color: AppColors.secondaryColorLight,
                          size: mobileWidth(context) * 0.2,
                        ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
