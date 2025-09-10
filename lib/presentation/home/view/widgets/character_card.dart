import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '/presentation/jws/view/jws_view.dart';
import '/core/common_widgets/common_widgets.dart';
import '/core/theme/theme.dart';
import '/core/constants/constants.dart';
import '/presentation/home/controller/home_controller.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kBodyHp * 1.5,
        vertical: kGap,
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Start learning",
              style: titleLargeStyle.copyWith(fontWeight: FontWeight.w400),
            ),
          ),
          const Gap(kGap / 1.5),
          Obx(
            () => Container(
              height: context.screenHeight * 0.37,
              color: AppColors.secondary(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _CharacterHeader(controller: controller),
                  Column(
                    children: [
                      Text(
                        controller.currentWord.value,
                        style: headlineLargeStyle,
                      ),
                      Text(
                        controller.currentRomaji.value,
                        style: titleMediumStyle,
                      ),
                    ],
                  ),
                  _CharacterButton(controller: controller),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CharacterHeader extends StatelessWidget {
  final HomeController controller;
  const _CharacterHeader({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kGap, left: kGap),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            color: AppColors.primary(context),
            size: secondaryIcon(context),
          ),
          const Gap(kGap),
          Text(controller.currentScriptDisplayName, style: titleLargeStyle),
          const Spacer(),
          IconActionButton(
            onTap: () => controller.onSpeak(controller.currentWord.value),
            icon: Icons.volume_up,
          ),
        ],
      ),
    );
  }
}

class _CharacterButton extends StatelessWidget {
  final HomeController controller;
  const _CharacterButton({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kElementGap),
      child: AppElevatedButton(
        onPressed: () {
          Get.to(() => JwsView(selectedWord: controller.currentWord.value));
        },
        icon: Icons.translate,
        label: 'Continue',
        width: context.screenWidth * 0.6,
        height: context.screenHeight * 0.075,
      ),
    );
  }
}
