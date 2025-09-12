import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '/presentation/practice/controller/practice_controller.dart';
import '/core/constants/constants.dart';
import '/core/theme/theme.dart';

class CorrectMeaningPage extends StatelessWidget {
  final PracticeController controller;

  const CorrectMeaningPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(kBodyHp),
          child: Column(
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
                      'Choose the Correct Meaning',
                      style: headlineMediumStyle,
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
                      'What does this mean?',
                      style: bodyLargeStyle,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const Gap(kBodyHp),
              ListView.builder(
                itemCount: controller.optionsPage1.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final option = controller.optionsPage1[index];
                  final correctAnswer = controller.currentWord!.english;
                  final selectedAnswer = controller.selectedAnswerPage1.value;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: kElementGap),
                    child: GestureDetector(
                      onTap: () => controller.selectAnswerPage1(option),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(kBodyHp),
                        decoration: AppDecorations.option(
                          isCorrect:
                              controller.showResultPage1.value &&
                              option == correctAnswer,
                          isWrong:
                              controller.showResultPage1.value &&
                              option == selectedAnswer &&
                              option != correctAnswer,
                        ),

                        child: Text(
                          option,
                          style: titleMediumStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                },
              ),
              if (controller.showResultPage1.value)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(kGap),
                  decoration: AppDecorations.option(
                    isCorrect:
                        controller.selectedAnswerPage1.value ==
                        controller.currentWord!.english,
                    isWrong:
                        controller.selectedAnswerPage1.value !=
                        controller.currentWord!.english,
                  ).copyWith(border: Border.all(color: AppColors.transparent)),
                  child: Text(
                    controller.selectedAnswerPage1.value ==
                            controller.currentWord!.english
                        ? 'Correct!'
                        : 'Incorrect. The correct answer is: ${controller.currentWord!.english}',
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
