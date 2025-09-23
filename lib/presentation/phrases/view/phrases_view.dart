import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '/presentation/phrases/controller/phrases_controller.dart';
import '/core/constants/constants.dart';
import '/core/theme/theme.dart';
import '/core/common_widgets/common_widgets.dart';
import 'widgets/phrase_card.dart';
import '/ad_manager/ad_manager.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<InterstitialAdManager>().checkAndDisplayAd();
    });
    final controller = Get.find<PhrasesController>();
    controller.setTopic(topicId, description);
    return Scaffold(
      appBar: TitleBar(title: "Phrases"),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.secondaryIcon(context),
            ),
          );
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
      bottomNavigationBar: Obx(() {
        final interstitial = Get.find<InterstitialAdManager>();
        return interstitial.isShow.value
            ? const SizedBox()
            : const BannerAdWidget();
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
                  onTap: controller.toggleDescriptionVisibility,
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
