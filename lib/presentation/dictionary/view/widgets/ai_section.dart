import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '/core/constants/constants.dart';
import '/core/theme/theme.dart';
import '/presentation/dictionary/controller/dictionary_controller.dart';

class AiSection extends StatelessWidget {
  const AiSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DictionaryController>();
    return Obx(() {
      if (controller.isAiLoading.value) {
        return Center(
          child: CircularProgressIndicator(
            color: AppColors.secondaryIcon(context),
          ),
        );
      }
      if (controller.wordDetails.value == null) {
        return const SizedBox.shrink();
      }
      final details = controller.wordDetails.value!;
      return Container(
        width: double.infinity,
        decoration: AppDecorations.rounded(context),
        padding: const EdgeInsets.all(kBodyHp),
        child: Column(
          children: [
            WordDetails(
              controller: controller,
              title: 'Definition',
              content: details.definition,
            ),
            const Gap(kGap),
            WordDetails(
              controller: controller,
              title: 'Parts of Speech',
              content: details.partOfSpeech,
            ),
            const Gap(kGap),
            WordDetails(
              controller: controller,
              title: 'Pronunciation',
              content: details.pronunciation,
            ),
            const Gap(kGap),
            WordDetails(
              controller: controller,
              title: 'Examples',
              content: details.examples,
            ),
            const Gap(kGap),
            WordDetails(
              controller: controller,
              title: 'Synonyms',
              content: details.synonyms,
            ),
            const Gap(kGap),
            WordDetails(
              controller: controller,
              title: 'Antonyms',
              content: details.antonyms,
            ),
            const Gap(kGap),
          ],
        ),
      );
    });
  }
}

class WordDetails extends StatelessWidget {
  final DictionaryController controller;
  final String title;
  final String content;

  const WordDetails({
    super.key,
    required this.controller,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text('• $title', style: titleSmallStyle)],
        ),
        const Gap(kElementGap),
        Text(content, style: bodyMediumStyle),
      ],
    );
  }
}
