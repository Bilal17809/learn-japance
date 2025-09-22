import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/utils/utils.dart';
import '/presentation/grammar/view/grammar_view.dart';
import '/core/common_widgets/common_widgets.dart';
import '/core/constants/constants.dart';
import '../controller/grammar_type_controller.dart';
import '/ad_manager/ad_manager.dart';

class GrammarTypeView extends StatelessWidget {
  GrammarTypeView({super.key});
  final controller = Get.find<GrammarTypeController>();
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<InterstitialAdManager>().checkAndDisplayAd();
    });
    return Scaffold(
      appBar: TitleBar(title: 'Select Category'),
      body: Obx(() {
        if (controller.translationsLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        final data = controller.grammarData;
        final categories = controller.getUniqueCategories(data!);
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: kBodyHp * 1.5,
              vertical: kBodyHp,
            ),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: kElementGap,
                mainAxisSpacing: kElementGap,
                childAspectRatio: 1.0,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return CategoryCard(
                  item: ItemsUtil.grammarItems[index],
                  category: category,
                  translatedCategory: controller.categoryTranslations[category],
                  onTap:
                      () =>
                          Get.to(() => GrammarView(selectedCategory: category)),
                );
              },
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
