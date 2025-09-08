import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/constants/constants.dart';
import '/core/common_widgets/common_widgets.dart';
import '../controller/conversation_controller.dart';
import 'widgets/conversation_card.dart';

class ConversationView extends StatelessWidget {
  final String category;
  final String categoryTranslation;
  final List<String> title;
  final List<String> titleTranslation;
  final List<String> conversation;
  final List<String> conversationTranslation;

  const ConversationView({
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
    final controller = Get.find<ConversationController>();
    return Scaffold(
      appBar: TitleBar(title: '$category - $categoryTranslation'),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(
            horizontal: kBodyHp,
            vertical: kGap,
          ),
          itemCount: title.length,
          itemBuilder: (context, index) {
            return ConversationCard(
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
