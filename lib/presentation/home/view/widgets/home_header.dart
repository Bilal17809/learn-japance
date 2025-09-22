import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '/presentation/home/controller/home_controller.dart';
import '/core/common_widgets/common_widgets.dart';
import '/core/theme/theme.dart';
import '/core/constants/constants.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kBodyHp * 1.5),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text("Overall Progress", style: titleLargeStyle),
          ),
          const Gap(kGap / 2),
          Obx(
            () => HorizontalProgress(
              currentStep: ((controller.overallProgress.value / 1395) * 100)
                  .toInt()
                  .clamp(0, 100),
            ),
          ),
        ],
      ),
    );
  }
}
