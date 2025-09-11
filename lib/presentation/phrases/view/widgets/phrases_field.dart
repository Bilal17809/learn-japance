import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '/data/models/models.dart';
import '/core/common_widgets/common_widgets.dart';
import '/presentation/phrases/controller/phrases_controller.dart';
import '/core/constants/constants.dart';
import '/core/theme/theme.dart';

class PhrasesField extends StatelessWidget {
  final String label, jpLabel, text, cacheKey;
  final IconData icon;
  final bool isExample;
  final PhrasesController controller;
  final PhrasesModel phrase;
  final int index;

  const PhrasesField({
    super.key,
    required this.label,
    required this.jpLabel,
    required this.text,
    required this.cacheKey,
    required this.icon,
    required this.controller,
    this.isExample = false,
    required this.phrase,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final translated = controller.translationCache[cacheKey];
      final isLearned = controller.learnedPhrases[phrase.id] ?? false;
      return Container(
        padding: const EdgeInsets.fromLTRB(kGap, kGap, kGap, 0),
        decoration: AppDecorations.highlight(context, isExample: isExample),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  size: smallIcon(context),
                  color: AppColors.icon(context),
                ),
                const Gap(kGap),
                Flexible(child: Text(text, style: titleSmallStyle)),
              ],
            ),
            const Gap(kGap),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(kGap),
                    decoration: AppDecorations.highlight(
                      context,
                      isExample: !isExample,
                    ),
                    child: Text(translated!, style: bodyLargeStyle),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconActionButton(
                  onTap: () => controller.onSpeak(translated),
                  icon: Icons.volume_up,
                ),
                IconActionButton(
                  onTap:
                      () => Clipboard.setData(
                        ClipboardData(text: '$text\n$translated'),
                      ),
                  icon: Icons.copy,
                ),
                isExample
                    ? IconActionButton(
                      onTap: () => controller.toggleExplanation(phrase.id),
                      icon:
                          (controller.showExplanation[phrase.id] ?? false)
                              ? Icons.arrow_drop_up
                              : Icons.arrow_drop_down,
                    )
                    : isLearned
                    ? SizedBox.shrink()
                    : IconActionButton(
                      onTap: () {
                        controller.learnPhrase(index);
                        SimpleToast.showCustomToast(
                          context: context,
                          message: 'Lesson learned',
                        );
                      },
                      icon: Icons.task_alt,
                    ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
