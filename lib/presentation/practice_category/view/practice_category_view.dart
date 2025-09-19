import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '/presentation/practice_selection/view/practice_selection_view.dart';
import '/presentation/practice_category/controller/practice_category_controller.dart';
import '/core/utils/utils.dart';
import '/core/common_widgets/common_widgets.dart';
import '/core/constants/constants.dart';
import '/data/models/learn_topic_model.dart';
import '/ad_manager/ad_manager.dart';

class PracticeCategoryView extends StatelessWidget {
  const PracticeCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<InterstitialAdManager>().checkAndDisplayAd();
    });
    final controller = Get.find<PracticeCategoryController>();
    return Scaffold(
      appBar: TitleBar(title: 'Practice'),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        final data = controller.topics;
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(kBodyHp),
            child: Column(
              children: [
                const Gap(kElementGap),
                Image.asset(
                  Assets.heroImage,
                  width: context.screenWidth * 0.41,
                ),
                const Gap(kElementGap),
                Expanded(child: _MenuGrid(data: data)),
              ],
            ),
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

class _MenuGrid extends StatelessWidget {
  final List<LearnTopicModel> data;

  const _MenuGrid({required this.data});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PracticeCategoryController>();
    final item = ItemsUtil.learnItems;
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: kGap,
        crossAxisSpacing: kGap,
        childAspectRatio: 1,
      ),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final topic = data[index];
        final progress = controller.categoryProgress[topic.english] ?? 0;

        return CategoryCard(
          isPractice: true,
          currentStep: progress,
          category: topic.japanese,
          translatedCategory: topic.english,
          item: item[index],
          onTap:
              () => Get.to(
                () => PracticeSelectionView(
                  topicId: index,
                  japCategory: topic.japanese,
                  category: topic.english,
                ),
              ),
        );
      },
    );
  }
}
