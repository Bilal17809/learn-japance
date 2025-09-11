import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '/core/common_widgets/common_widgets.dart';
import '../../controller/dialogue_controller.dart';
import '/core/constants/constants.dart';
import '/core/theme/theme.dart';
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

      return Card(
        child: Padding(
          padding: const EdgeInsets.all(kGap),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: titleLargeStyle),
                  Text(titleTranslation, style: bodyMediumStyle),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: DialgoueField(
                    text: conversation,
                    translated: conversationTranslation,
                    icon: Icons.chat_bubble,
                    controller: controller,
                  ),
                ),
              ),
              const Gap(kGap),
              AppElevatedButton(
                onPressed:
                    isLearned
                        ? null
                        : () => controller.learnDialogue(category, index),
                icon: Icons.check_circle,
                label: isLearned ? 'Learned' : 'Mark as Learned',
                backgroundColor: isLearned ? Colors.grey : null,
              ),
            ],
          ),
        ),
      );
    });
  }
}
