import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '/core/common_widgets/common_widgets.dart';
import '/presentation/practice/controller/practice_controller.dart';
import '/core/constants/constants.dart';
import '/core/theme/theme.dart';

class WritingTestPage extends StatelessWidget {
  final PracticeController controller;

  const WritingTestPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    return Obx(
      () => ListView(
        padding: const EdgeInsets.all(kBodyHp),
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
                  'Writing Test',
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
                  'Write the English meaning:',
                  style: bodyLargeStyle,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const Gap(kElementGap),
          InputField(
            controller: textController,
            hintText: 'Type your answer here...',
            hintStyle: titleMediumStyle,
            onChanged: controller.updateTextInput,
            textStyle: titleMediumStyle,
            textAlign: TextAlign.center,
            contentPadding: const EdgeInsets.all(kBodyHp),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kBorderRadius),
            ),
          ),
          const Gap(kElementGap),
          if (controller.userTextInput.value.isNotEmpty &&
              !controller.showResultPage4.value)
            AppElevatedButton(
              onPressed: controller.checkWritingAnswer,
              label: 'Check Answer',
              width: double.infinity,
              icon: Icons.check_circle,
            ),
          if (controller.showResultPage4.value)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(kGap),
              decoration: AppDecorations.option(
                isCorrect: controller.isCorrectPage4.value,
                isWrong: !controller.isCorrectPage4.value,
              ).copyWith(border: Border.all(color: AppColors.transparent)),
              child: Text(
                controller.isCorrectPage4.value
                    ? 'Correct!'
                    : 'Incorrect. The correct answer is: ${controller.currentWord!.english}',
                style: titleMediumStyle,
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }
}
