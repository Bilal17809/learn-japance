import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_japan/core/theme/theme.dart';
import '/core/constants/constants.dart';
import '/core/common_widgets/common_widgets.dart';
import '../controller/dialogue_controller.dart';
import 'widgets/dialogue_card.dart';

class DialgoueView extends StatelessWidget {
  final String category;
  final String categoryTranslation;
  final List<String> title;
  final List<String> titleTranslation;
  final List<String> conversation;
  final List<String> conversationTranslation;

  const DialgoueView({
    super.key,
    required this.category,
    required this.title,
    required this.conversation,
    required this.categoryTranslation,
    required this.titleTranslation,
    required this.conversationTranslation,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DialogueController>();
    controller.loadLearnedDialogues(category, title.length);

    final pageController = PageController();

    return Scaffold(
      appBar: TitleBar(title: '$category - $categoryTranslation'),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                onPageChanged: (pageIndex) {
                  controller.index.value = pageIndex;
                  controller.stopTts();
                },
                itemCount: title.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(kBodyHp),
                    child: DialgoueCard(
                      title: title[index],
                      category: category,
                      titleTranslation: titleTranslation[index],
                      conversation: conversation[index].replaceAll('~', '\n'),
                      conversationTranslation: conversationTranslation[index]
                          .replaceAll('〜', '\n')
                          .replaceAll('～', '\n'),
                      controller: controller,
                      index: index,
                    ),
                  );
                },
              ),
            ),
            Obx(() {
              return Padding(
                padding: const EdgeInsets.only(bottom: kGap),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(title.length, (dotIndex) {
                    final isActive = controller.index.value == dotIndex;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: isActive ? 8 : 8,
                      height: 8,
                      decoration: AppDecorations.roundedIcon(context).copyWith(
                        color:
                            isActive
                                ? AppColors.primary(context)
                                : AppColors.kGrey.withValues(alpha: 0.7),
                      ),
                    );
                  }),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
