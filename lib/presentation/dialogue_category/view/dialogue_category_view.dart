import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/presentation/dialogue/view/dialogue_view.dart';
import '/core/theme/theme.dart';
import '/core/constants/constants.dart';
import '/core/common_widgets/common_widgets.dart';
import '/presentation/dialogue_category/controller/dialogue_category_controller.dart';
import '/ad_manager/ad_manager.dart';

class DialogueCategoryView extends StatelessWidget {
  const DialogueCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<InterstitialAdManager>().checkAndDisplayAd();
    });
    final controller = Get.find<DialogueCategoryController>();
    final searchController = TextEditingController();
    return Scaffold(
      appBar: TitleBar(title: 'Choose Category'),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.secondaryIcon(context),
            ),
          );
        }
        final categories = controller.getFilteredCat();
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
                  onSearch: (val) => controller.searchQuery.value = val,
                ),
              ),
              Expanded(
                child:
                    categories.isEmpty
                        ? LottieWidget()
                        : ListView.builder(
                          padding: const EdgeInsets.symmetric(
                            horizontal: kBodyHp,
                          ),
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            final category = categories[index];
                            return _CategoryCard(category: category);
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

class _CategoryCard extends StatelessWidget {
  final String category;
  const _CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DialogueCategoryController>();
    final conversationModels =
        controller.category.where((c) => c.category == category).toList();

    if (conversationModels.isEmpty) return const SizedBox.shrink();
    final conversationModel = conversationModels.first;

    return ClipPath(
      clipper: TicketClipper(),
      child: GestureDetector(
        onTap: () {
          Get.to(
            () => DialgoueView(
              category: conversationModel.category,
              categoryTranslation: conversationModel.categoryTranslation,
              title: conversationModels.map((c) => c.title).toList(),
              titleTranslation:
                  conversationModels.map((c) => c.titleTrans).toList(),
              conversation:
                  conversationModels.map((c) => c.conversation).toList(),
              conversationTranslation:
                  conversationModels
                      .map((c) => c.conversationTranslation) // fullwidth tilde
                      .toList(),
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: kElementGap),
          padding: const EdgeInsets.all(kBodyHp),
          decoration: AppDecorations.rounded(context),
          child: ListTile(
            title: Text(
              category,
              style: titleMediumStyle.copyWith(fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              conversationModel.categoryTranslation,
              textAlign: TextAlign.right,
              style: titleMediumStyle.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}
