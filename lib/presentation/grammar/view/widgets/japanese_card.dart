import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '/core/common_widgets/common_widgets.dart';
import '/core/constants/constants.dart';
import '/core/theme/theme.dart';
import '/data/models/grammar_model.dart';
import '../../controller/grammar_controller.dart';
import 'translation_field.dart';

class JapaneseCard extends StatelessWidget {
  final GrammarModel item;
  final GrammarController controller;
  final int index;

  const JapaneseCard({
    super.key,
    required this.item,
    required this.controller,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(kGap),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kGap,
                    vertical: kGap / 2,
                  ),
                  decoration: AppDecorations.roundedIcon(context),
                  child: Text(
                    "${index + 1}",
                    style: bodyMediumStyle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Gap(kGap),
                Expanded(child: Text(item.title, style: titleLargeStyle)),
              ],
            ),
            const Gap(kElementGap),
            TranslationField(
              label: "Category",
              jpLabel: "カテゴリー",
              text: item.category,
              cacheKey: "${item.id}_category",
              icon: Icons.category_rounded,
              controller: controller,
            ),
            const Gap(kGap),

            TranslationField(
              label: "Description",
              jpLabel: "説明",
              text: item.description,
              cacheKey: "${item.id}_description",
              icon: Icons.description,
              controller: controller,
            ),
            const Gap(kGap),
            ...item.examples.asMap().entries.map((e) {
              final index = e.key;
              final example = e.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: kGap),
                child: TranslationField(
                  label: "Example ${index + 1}",
                  jpLabel: "例文",
                  text: example,
                  cacheKey: "${item.id}_example_$index",
                  icon: Icons.format_quote,
                  isExample: true,
                  controller: controller,
                ),
              );
            }),
            Center(
              child: AppElevatedButton(
                onPressed: () => controller.translateAll(item),
                icon: Icons.translate,
                label: 'Translate All',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
