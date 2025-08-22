import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:learn_japan/core/common_widgets/common_widgets.dart';
import '/core/theme/theme.dart';
import '/core/utils/utils.dart';
import '/core/constants/constants.dart';

class BottomSection extends StatelessWidget {
  const BottomSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kBodyHp * 1.5),
        child: Column(
          children: [
            Divider(color: AppColors.primary(context)),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Today Progress", style: bodyMediumStyle),
            ),
            const Gap(kGap),
            HorizontalProgress(currentStep: 57),
            const Gap(kGap),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                _ProgressColumn(value: 10, label: "Lessons"),
                _ProgressColumn(value: 30, label: "Words"),
                _ProgressColumn(value: 5, label: "Sentences"),
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
