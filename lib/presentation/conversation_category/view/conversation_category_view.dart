import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_japan/core/utils/assets_util.dart';
import 'package:learn_japan/presentation/conversation/view/conversation_view.dart';
import 'package:lottie/lottie.dart';
import '/core/theme/theme.dart';
import '/core/constants/constants.dart';
import '/core/common_widgets/common_widgets.dart';
import '/presentation/conversation_category/controller/conversation_category_controller.dart';

class ConversationCategoryView extends StatelessWidget {
  const ConversationCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ConversationCategoryController>();
    return Scaffold(
      appBar: TitleBar(title: 'Choose Category'),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
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
                  controller: controller.searchController,
                  onSearch: (val) => controller.searchQuery.value = val,
                ),
              ),
              Expanded(
                child:
                    categories.isEmpty
                        ? Center(
                          child: Opacity(
                            opacity: 0.5,
                            child: Lottie.asset(
                              Assets.searchError,
                              width: context.screenWidth * 0.41,
                            ),
                          ),
                        )
                        : ListView.builder(
                          padding: const EdgeInsets.symmetric(
                            horizontal: kBodyHp,
                          ),
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            final category = categories[index];
                            return _CategoriesCard(category: category);
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

class _CategoriesCard extends StatelessWidget {
  final String category;
  const _CategoriesCard({required this.category});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ConversationCategoryController>();
    final conversationModels =
        controller.category.where((c) => c.category == category).toList();

    if (conversationModels.isEmpty) return const SizedBox.shrink();
    final conversationModel = conversationModels.first;

    return GestureDetector(
      onTap: () {
        Get.to(
          () => ConversationView(
            cat: conversationModel.category,
            catTrans: conversationModel.categoryTranslation,
            title: conversationModels.map((c) => c.title).toList(),
            titleTranslation:
                conversationModels.map((c) => c.titleTrans).toList(),
            conversation:
                conversationModels
                    .map((c) => c.conversation.replaceAll('~', '\n'))
                    .toList(),
            conversationTranslation:
                conversationModels
                    .map((c) => c.conversationTranslation.replaceAll('~', '\n'))
                    .toList(),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: kElementGap),
        padding: const EdgeInsets.all(kBodyHp),
        decoration: AppDecorations.simpleDecor(context),
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
    );
  }
}
