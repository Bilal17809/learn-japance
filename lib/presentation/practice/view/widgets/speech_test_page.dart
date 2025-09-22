import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '/core/common_widgets/common_widgets.dart';
import '/presentation/practice/controller/practice_controller.dart';
import '/core/constants/constants.dart';
import '/core/theme/theme.dart';

class SpeechTestPage extends StatelessWidget {
  final PracticeController controller;

  const SpeechTestPage({super.key, required this.controller});

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
                      'Pronunciation Test',
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
                      'Pronounce this word correctly',
                      style: bodyLargeStyle,
                      textAlign: TextAlign.center,
                    ),
                    const Gap(kGap),
                    AppElevatedButton(
                      onPressed: () => controller.handleSpeechPracticeInput(),
                      icon: Icons.mic,
                      label: 'Start Recording',
                    ),
                    const Gap(kGap),
                    Text(
                      'Tap the microphone and speak the word',
                      style: bodySmallStyle,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const Gap(kElementGap),
              if (controller.showResultSpeech.value)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(kGap),
                  decoration: AppDecorations.option(
                    isCorrect: controller.isCorrectSpeech.value,
                    isWrong: !controller.isCorrectSpeech.value,
                  ).copyWith(border: Border.all(color: AppColors.transparent)),
                  child: Text(
                    controller.isCorrectSpeech.value
                        ? 'Correct!'
                        : 'Incorrect. The correct answer is: ${controller.currentWord!.japanese}',
                    style: titleMediumStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
