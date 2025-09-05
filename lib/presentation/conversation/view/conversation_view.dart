import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/constants/constants.dart';
import '/core/common_widgets/common_widgets.dart';
import '../controller/conversation_controller.dart';
import 'widgets/convo_card.dart';

class ConversationView extends StatelessWidget {
  final String cat;
  final String catTrans;
  final List<String> title;
  final List<String> titleTranslation;
  final List<String> conversation;
  final List<String> conversationTranslation;

  const ConversationView({
    super.key,
    required this.cat,
    required this.title,
    required this.conversation,
    required this.catTrans,
    required this.titleTranslation,
    required this.conversationTranslation,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ConversationController>();
    return Scaffold(
      appBar: TitleBar(title: '$cat - $catTrans'),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(
            horizontal: kBodyHp,
            vertical: kGap,
          ),
          itemCount: title.length,
          itemBuilder: (context, index) {
            return ConvoCard(
              title: title[index],
              titleTranslation: titleTranslation[index],
              conversation: conversation[index],
              conversationTranslation: conversationTranslation[index],
              controller: controller,
              index: index,
            );
          },
        ),
      ),
    );
  }
}
