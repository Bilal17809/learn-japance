import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '/presentation/convo/view/widgets/convo_field.dart';
import '../../controller/convo_controller.dart';
import '/core/common_widgets/common_widgets.dart';
import '/core/constants/constants.dart';
import '/core/theme/theme.dart';

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
    return Card(
      margin: const EdgeInsets.only(bottom: kElementGap),
      child: Padding(
        padding: const EdgeInsets.all(kGap),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Conversation ${index + 1}", style: titleLargeStyle),
              ],
            ),
            const Gap(kElementGap),
            ConvoField(
              label: "Title",
              jpLabel: "タイトル",
              text: title,
              cacheKey: "title_$index",
              icon: Icons.title,
              controller: controller,
            ),
            const Gap(kGap),
            ConvoField(
              label: "Conversation",
              jpLabel: "会話",
              text: conversation,
              cacheKey: "convo_$index",
              icon: Icons.chat,
              isExample: true,
              controller: controller,
            ),
            const Gap(kGap),
            Center(
              child: AppElevatedButton(
                onPressed: () => controller.translateConversation(index),
                icon: Icons.translate,
                label: 'Translate All',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
