import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_japan/core/utils/assets_util.dart';
import 'package:learn_japan/presentation/convo/view/convo_view.dart';
import 'package:lottie/lottie.dart';
import '/core/theme/theme.dart';
import '/core/constants/constants.dart';
import '/core/common_widgets/common_widgets.dart';
import '/presentation/convo_cat/controller/convo_cat_controller.dart';

class ConvoCatView extends StatelessWidget {
  const ConvoCatView({super.key});

  @override
  Widget build(BuildContext context) {
    final convoController = Get.find<ConvoCatController>();
    return Scaffold(
      appBar: TitleBar(title: 'Conversation'),
      body: Obx(() {
        if (convoController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        final cat = convoController.getFilteredCat();
        return SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kBodyHp,
                  vertical: kGap,
                ),
                child: SearchBarField(
                  controller: convoController.searchController,
                  onSearch: (val) => convoController.searchQuery.value = val,
                ),
              ),
              Expanded(
                child:
                    cat.isEmpty
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
                          itemCount: cat.length,
                          itemBuilder: (context, index) {
                            final category = cat[index];
                            return _CatCard(cat: category);
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

class _CatCard extends StatelessWidget {
  final String cat;
  const _CatCard({required this.cat});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ConvoCatController>();
    final index = controller.uniqueCat.indexOf(cat);
    return GestureDetector(
      onTap: () {
        Get.to(() {
          final filtered =
              controller.cat.where((c) => c.category == cat).toList();
          return ConvoView(
            category: cat,
            titles: filtered.map((c) => c.title).toList(),
            conversations:
                filtered
                    .map((c) => c.conversation.replaceAll('~', '\n\n'))
                    .toList(),
          );
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: kElementGap),
        padding: const EdgeInsets.all(kBodyHp),
        decoration: AppDecorations.simpleDecor(context),
        child: Obx(() {
          final translated = controller.catTranslations[index];
          return ListTile(
            title: Align(alignment: Alignment.topLeft, child: Text(cat)),
            subtitle: Align(
              alignment: Alignment.bottomRight,
              child: Text(translated),
            ),
          );
        }),
      ),
    );
  }
}
