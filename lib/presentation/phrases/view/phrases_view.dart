import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '/core/constants/constants.dart';
import '/core/theme/theme.dart';
import '/core/common_widgets/common_widgets.dart';
import '../controller/phrases_controller.dart';
import 'widgets/phrase_card.dart';

class PhrasesView extends StatelessWidget {
  final int topicId;
  final String description;

  const PhrasesView({
    super.key,
    required this.topicId,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PhrasesController>();
    controller.setTopic(topicId, description);

    return Scaffold(
      appBar: TitleBar(title: "Phrases"),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = controller.phrases;
        return SafeArea(
          child: Column(
            children: [
              if (description.isNotEmpty)
                _DescriptionWidget(
                  description: description,
                  controller: controller,
                ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: kBodyHp),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return PhraseCard(
                      phrase: data[index],
                      controller: controller,
                      index: index,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _DescriptionWidget extends StatelessWidget {
  final String description;
  final PhrasesController controller;

  const _DescriptionWidget({
    required this.description,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kBodyHp,
        vertical: kElementGap,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            description,
            style: bodyLargeStyle.copyWith(fontWeight: FontWeight.w500),
          ),
          const Gap(kGap / 2),
          Obx(() {
            final translated = controller.translatedDescription.value;
            if (translated.isEmpty) return const SizedBox.shrink();
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child:
                      controller.showTranslation.value
                          ? Text(translated, style: bodyMediumStyle)
                          : const SizedBox.shrink(),
                ),
                IconActionButton(
                  onTap: controller.toggleTranslationVisibility,
                  icon: Icons.arrow_drop_down,
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
