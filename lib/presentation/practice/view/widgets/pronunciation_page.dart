import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '/core/common_widgets/common_widgets.dart';
import '/presentation/practice/controller/practice_controller.dart';
import '/core/constants/constants.dart';
import '/core/theme/theme.dart';

class PronunciationPage extends StatelessWidget {
  final PracticeController controller;

  const PronunciationPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(kBodyHp),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(kBodyHp),
                decoration: AppDecorations.rounded(context).copyWith(
                  border: Border.all(
                    color: AppColors.kGrey.withValues(alpha: 0.75),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      'Pronunciation Example',
                      style: headlineSmallStyle,
                      textAlign: TextAlign.center,
                    ),
                    const Gap(kGap),
                    Text(
                      controller.currentWord!.japanese,
                      style: headlineLargeStyle,
                      textAlign: TextAlign.center,
                    ),
                    const Gap(kGap),
                    Text(
                      controller.currentWord!.english,
                      style: titleLargeStyle,
                      textAlign: TextAlign.center,
                    ),
                    const Gap(kGap),
                    Text(
                      'Listen and repeat the pronunciation',
                      style: bodyLargeStyle,
                      textAlign: TextAlign.center,
                    ),
                    const Gap(kGap),
                    AppElevatedButton(
                      onPressed:
                          () => controller.onSpeak(
                            controller.currentWord!.japanese,
                          ),
                      icon: Icons.volume_up,
                      label: 'Play Pronunciation',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
