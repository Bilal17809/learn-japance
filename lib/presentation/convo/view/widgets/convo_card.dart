import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '/presentation/convo/view/widgets/convo_field.dart';
import '../../controller/convo_controller.dart';
import '/core/constants/constants.dart';

class ConvoCard extends StatelessWidget {
  final String title;
  final String conversation;
  final ConvoController controller;
  final int index;

  const ConvoCard({
    super.key,
    required this.title,
    required this.conversation,
    required this.controller,
    required this.index,
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
              label: "Title",
              jpLabel: "タイトル",
              text: title,
              cacheKey: "title_$index",
              icon: Icons.title,
              controller: controller,
              index: index,
            ),
            if (controller.translationCache["title_$index"] != null) ...[
              const Gap(kGap),
              ConvoField(
                label: "Conversation",
                jpLabel: "会話",
                text: conversation,
                cacheKey: "convo_$index",
                icon: Icons.chat,
                isExample: true,
                controller: controller,
                index: index,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
