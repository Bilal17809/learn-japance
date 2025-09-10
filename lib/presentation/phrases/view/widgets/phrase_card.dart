import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../core/common_widgets/buttons.dart';
import '../../controller/phrases_controller.dart';
import '/core/constants/constants.dart';
import '/data/models/models.dart';
import 'phrases_field.dart';

class PhraseCard extends StatelessWidget {
  final PhrasesModel phrase;
  final PhrasesController controller;
  final int index;

  const PhraseCard({
    super.key,
    required this.phrase,
    required this.controller,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kGap),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PhrasesField(
            label: "Explanation",
            jpLabel: "説明",
            text: phrase.explanation,
            cacheKey: "translation_${phrase.id}_explanation",
            icon: Icons.description,
            controller: controller,
          ),
          const Gap(kGap),
          PhrasesField(
            label: "Sentence",
            jpLabel: "文",
            text: phrase.sentence,
            cacheKey: "translation_${phrase.id}_sentence",
            icon: Icons.format_quote,
            isExample: true,
            controller: controller,
          ),
          const Gap(kBodyHp),
          Center(
            child: Obx(() {
              final isLearned = controller.learnedPhrases[phrase.id] ?? false;
              return AppElevatedButton(
                onPressed:
                    isLearned ? null : () => controller.learnPhrase(index),
                icon: Icons.translate,
                label: isLearned ? 'Learned' : 'Learn this Phrase',
                backgroundColor: isLearned ? Colors.grey : null,
              );
            }),
          ),
        ],
      ),
    );
  }
}
