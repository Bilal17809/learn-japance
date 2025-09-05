import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../controller/conversation_controller.dart';
import '/core/constants/constants.dart';
import 'convo_field.dart';

class ConvoCard extends StatelessWidget {
  final int index;
  final String title;
  final String titleTranslation;
  final String conversation;
  final String conversationTranslation;
  final ConversationController controller;

  const ConvoCard({
    super.key,
    required this.index,
    required this.title,
    required this.titleTranslation,
    required this.conversation,
    required this.conversationTranslation,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(kGap),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConvoField(
              index: index,
              label: "Title",
              jpLabel: "タイトル",
              text: title,
              translated: titleTranslation,
              icon: Icons.title,
              controller: controller,
            ),
            if (controller.isExpanded(index)) ...[
              const Gap(kGap),
              ConvoField(
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
          ],
        ),
      ),
    );
  }
}
