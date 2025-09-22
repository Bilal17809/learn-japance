import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/common_widgets/common_widgets.dart';
import '/core/constants/constants.dart';
import '/presentation/grammar/controller/grammar_controller.dart';
import 'widgets/grammar_card.dart';
import '/ad_manager/ad_manager.dart';

class GrammarView extends StatelessWidget {
  final String selectedCategory;
  const GrammarView({super.key, required this.selectedCategory});
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<InterstitialAdManager>().checkAndDisplayAd();
    });
    final GrammarController controller = Get.find<GrammarController>();
    final searchController = TextEditingController();
    return Scaffold(
      appBar: TitleBar(title: selectedCategory),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        final data = controller.getFilteredData(selectedCategory);
        return SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kBodyHp,
                  vertical: kGap,
                ),
                child: SearchBarField(
                  controller: searchController,
                  onSearch: (value) => controller.searchQuery.value = value,
                ),
              ),
              Expanded(
                child:
                    data.isEmpty
                        ? LottieWidget()
                        : ListView.builder(
                          padding: const EdgeInsets.symmetric(
                            horizontal: kBodyHp,
                            vertical: kGap,
                          ),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return GrammarCard(
                              item: data[index],
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
