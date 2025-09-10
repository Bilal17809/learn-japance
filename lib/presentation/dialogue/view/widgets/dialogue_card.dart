import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../core/common_widgets/buttons.dart';
import '../../controller/dialogue_controller.dart';
import '/core/constants/constants.dart';
import 'dialogue_field.dart';

class DialgoueCard extends StatelessWidget {
  final int index;
  final String title;
  final String titleTranslation;
  final String conversation;
  final String conversationTranslation;
  final DialogueController controller;
  final String category;

  const DialgoueCard({
    super.key,
    required this.index,
    required this.title,
    required this.titleTranslation,
    required this.conversation,
    required this.conversationTranslation,
    required this.controller,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isLearned =
          controller.learnedDialogues["${category}_$index"] ?? false;
      return Padding(
        padding: const EdgeInsets.all(kGap),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DialgoueField(
              index: index,
              label: "Title",
              jpLabel: "タイトル",
              text: title,
              translated: titleTranslation,
              icon: Icons.title,
              controller: controller,
            ),
            controller.isExpanded(index)
                ? Column(
                  children: [
                    const Gap(kGap),
                    DialgoueField(
                      index: index,
                      label: "Conversation",
                      jpLabel: "会話",
                      text: conversation,
                      translated: conversationTranslation,
                      icon: Icons.chat,
                      isTransField: true,
                      controller: controller,
                    ),
                  ],
                )
                : const SizedBox.shrink(),
            const Gap(kBodyHp),
            Center(
              child: AppElevatedButton(
                onPressed:
                    isLearned
                        ? null
                        : () => controller.learnDialogue(category, index),
                icon: Icons.chat,
                label: isLearned ? 'Learned' : 'Learn this Dialogue',
                backgroundColor: isLearned ? Colors.grey : null,
              ),
            ),
          ],
        ),
      );
    });
  }
}
