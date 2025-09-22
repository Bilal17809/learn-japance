import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '/presentation/learn/view/learn_view.dart';
import '/core/utils/utils.dart';
import '/presentation/learn_category/controller/learn_category_controller.dart';
import '/core/common_widgets/common_widgets.dart';
import '/core/constants/constants.dart';
import '/data/models/learn_topic_model.dart';
import '/ad_manager/ad_manager.dart';

class LearnCategoryView extends StatelessWidget {
  const LearnCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<InterstitialAdManager>().checkAndDisplayAd();
    });
    final controller = Get.find<LearnCategoryController>();
    return Scaffold(
      appBar: TitleBar(title: 'Learn Japanese'),
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
                Image.asset(Assets.heroImg, width: context.screenWidth * 0.41),
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
    final item = ItemsUtil.learnItems;
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: kGap,
        crossAxisSpacing: kGap,
        childAspectRatio: 1,
      ),
      itemCount: item.length,
      itemBuilder: (context, index) {
        return CategoryCard(
          category: data[index].japanese,
          translatedCategory: data[index].english,
          onTap:
              () => Get.to(
                () => LearnView(
                  topicId: index,
                  japCategory: data[index].japanese,
                  category: data[index].english,
                ),
              ),
          item: item[index],
        );
      },
    );
  }
}
