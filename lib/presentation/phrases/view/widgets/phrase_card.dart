import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
            cacheKey: "${phrase.id}_explanation",
            icon: Icons.description,
            controller: controller,
          ),
          const Gap(kGap),
          PhrasesField(
            label: "Sentence",
            jpLabel: "文",
            text: phrase.sentence,
            cacheKey: "${phrase.id}_sentence",
            icon: Icons.format_quote,
            isExample: true,
            controller: controller,
          ),
          // const Gap(kGap),
          // Center(
          //   child: AppElevatedButton(
          //     onPressed: () => controller.translateAll(phrase),
          //     icon: Icons.translate,
          //     label: 'Translate All',
          //   ),
          // ),
        ],
      ),
    );
  }
}
