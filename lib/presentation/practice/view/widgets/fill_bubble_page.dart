import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '/presentation/practice/controller/practice_controller.dart';
import '/core/constants/constants.dart';
import '/core/theme/theme.dart';

class FillBubblePage extends StatelessWidget {
  final PracticeController controller;

  const FillBubblePage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(kBodyHp),
        child: SingleChildScrollView(
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
                      'Fill in the Bubble',
                      style: headlineSmallStyle,
                      textAlign: TextAlign.center,
                    ),
                    const Gap(kGap),
                    Text(
                      'Select the correct meaning for:',
                      style: bodyLargeStyle,
                      textAlign: TextAlign.center,
                    ),
                    const Gap(kGap),
                    Text(
                      controller.currentWord!.japanese,
                      style: headlineLargeStyle,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const Gap(kElementGap),
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2.5,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.optionsPage2.length,
                itemBuilder: (context, index) {
                  final option = controller.optionsPage2[index];
                  final correctAnswer = controller.currentWord!.english;
                  final selectedAnswer = controller.selectedAnswerPage2.value;
                  return GestureDetector(
                    onTap: () => controller.selectAnswerPage2(option),
                    child: Container(
                      decoration: AppDecorations.option(
                        isCorrect:
                            controller.showResultPage2.value &&
                            option == correctAnswer,
                        isWrong:
                            controller.showResultPage2.value &&
                            option == selectedAnswer &&
                            option != correctAnswer,
                      ),
                      padding: const EdgeInsets.all(kGap / 2),
                      child: Center(
                        child: Text(
                          option,
                          style: titleSmallStyle,
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                      ),
                    ),
                  );
                },
              ),
              if (controller.showResultPage2.value)
                Padding(
                  padding: const EdgeInsets.only(top: kElementGap),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(kGap),
                    decoration: AppDecorations.option(
                      isCorrect:
                          controller.selectedAnswerPage2.value ==
                          controller.currentWord!.english,
                      isWrong:
                          controller.selectedAnswerPage2.value !=
                          controller.currentWord!.english,
                    ).copyWith(
                      border: Border.all(color: AppColors.transparent),
                    ),
                    child: Text(
                      controller.selectedAnswerPage2.value ==
                              controller.currentWord!.english
                          ? 'Correct!'
                          : 'Incorrect. The correct answer is: ${controller.currentWord!.english}',
                      style: titleMediumStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
