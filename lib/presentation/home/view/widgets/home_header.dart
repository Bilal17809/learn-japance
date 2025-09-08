import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '/core/common_widgets/common_widgets.dart';
import '/core/theme/theme.dart';
import '/core/constants/constants.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kBodyHp * 1.5),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text("Japanese", style: titleLargeStyle),
          ),
          const Gap(kGap / 2),
          HorizontalProgress(currentStep: 34),
          const Gap(kGap / 2),
          Row(
            children: [
              Text("Today's goal:", style: bodyMediumStyle),
              const SizedBox(width: 6),
              Text(
                "10 XP",
                style: bodyMediumStyle.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
