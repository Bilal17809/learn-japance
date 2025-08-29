import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/constants/constants.dart';
import '/core/common_widgets/common_widgets.dart';
import '../controller/convo_controller.dart';
import 'widgets/convo_card.dart';

class ConvoView extends StatelessWidget {
  final String category;
  final List<String> titles;
  final List<String> conversations;

  const ConvoView({
    super.key,
    required this.category,
    required this.titles,
    required this.conversations,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ConvoController>();
    controller.setArgs(titles: titles, conversations: conversations);

    return Scaffold(
      appBar: TitleBar(title: category),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: kBodyHp,
                  vertical: kGap,
                ),
                itemCount: titles.length,
                itemBuilder: (context, index) {
                  return ConvoCard(
                    title: titles[index],
                    conversation: conversations[index],
                    controller: controller,
                    index: index,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
