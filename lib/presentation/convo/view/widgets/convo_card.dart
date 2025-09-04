import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../controller/convo_controller.dart';
import '/core/constants/constants.dart';
import 'convo_field.dart';

class ConvoCard extends StatelessWidget {
  final int index;
  final String title;
  final String titleTrans;
  final String conversation;
  final String convoTrans;
  final ConvoController controller;

  const ConvoCard({
    super.key,
    required this.index,
    required this.title,
    required this.titleTrans,
    required this.conversation,
    required this.convoTrans,
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
              translated: titleTrans,
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
                translated: convoTrans,
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
