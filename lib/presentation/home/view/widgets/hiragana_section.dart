import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '/presentation/characters/view/characters_view.dart';
import '/core/common_widgets/common_widgets.dart';
import '/core/theme/theme.dart';
import '/core/constants/constants.dart';

class HiraganaSection extends StatelessWidget {
  const HiraganaSection({super.key});

  @override
  Widget build(BuildContext context) {
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
          Container(
            height: context.screenHeight * 0.37,
            color: AppColors.secondary(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: kGap, left: kGap),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: AppColors.primary(context),
                        size: secondaryIcon(context),
                      ),
                      const Gap(kGap),
                      Text("Hiragana", style: titleLargeStyle),
                    ],
                  ),
                ),
                Center(child: Text("あ", style: headlineLargeStyle)),
                Padding(
                  padding: const EdgeInsets.only(bottom: kElementGap),
                  child: AppElevatedButton(
                    onPressed: () => Get.to(() => CharactersView()),
                    icon: Icons.translate,
                    label: 'Continue',
                    width: context.screenWidth * 0.6,
                    height: context.screenHeight * 0.075,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
