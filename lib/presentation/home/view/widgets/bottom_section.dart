import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '/presentation/home/controller/home_controller.dart';
import '/core/common_widgets/common_widgets.dart';
import '/core/theme/theme.dart';
import '/core/utils/utils.dart';
import '/core/constants/constants.dart';

class BottomSection extends StatelessWidget {
  const BottomSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Obx(
      () => Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kBodyHp * 1.5),
          child: Column(
            children: [
              Divider(color: AppColors.primary(context)),

              const Gap(kGap),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Today's Progress", style: titleSmallStyle),
                  const Spacer(),
                  Text("Today's goal:", style: bodyMediumStyle),
                  const Gap(kGap / 2),
                  Text(
                    "10 XP",
                    style: bodyMediumStyle.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const Gap(kGap),
              HorizontalProgress(
                currentStep: ((controller.dailyProgress.value / 10) * 100)
                    .toInt()
                    .clamp(0, 100),
              ),
              const Gap(kGap),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _ProgressColumn(
                    value: controller.phrasesLearnedToday.value,
                    label: "Phrases",
                  ),
                  _ProgressColumn(
                    value: controller.dialoguesLearnedToday.value,
                    label: "Dialogues",
                  ),
                  _ProgressColumn(
                    value: controller.practiceToday.value,
                    label: "Practice",
                  ),
                ],
              ),
              Divider(color: AppColors.primary(context)),
              const Spacer(),
              Row(
                children: [
                  Text("Streak", style: titleLargeStyle),
                  Spacer(),
                  Image.asset(Assets.star, width: primaryIcon(context)),
                  const Gap(kGap / 2),
                  Text("5 achievements", style: titleSmallStyle),
                ],
              ),
              const Gap(kBodyHp),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProgressColumn extends StatelessWidget {
  final int value;
  final String label;

  const _ProgressColumn({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value.toString(),
          style: titleMediumStyle.copyWith(color: AppColors.primary(context)),
        ),
        const Gap(kGap),
        Text(
          label,
          style: titleSmallStyle.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
