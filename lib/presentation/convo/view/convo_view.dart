import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/constants/constants.dart';
import '/core/common_widgets/common_widgets.dart';
import '../controller/convo_controller.dart';
import 'widgets/convo_card.dart';

class ConvoView extends StatelessWidget {
  final String cat;
  final String catTrans;
  final List<String> titles;
  final List<String> titlesTrans;
  final List<String> convos;
  final List<String> convosTrans;

  const ConvoView({
    super.key,
    required this.cat,
    required this.titles,
    required this.convos,
    required this.catTrans,
    required this.titlesTrans,
    required this.convosTrans,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ConvoController>();
    return Scaffold(
      appBar: TitleBar(title: '$cat - $catTrans'),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(
            horizontal: kBodyHp,
            vertical: kGap,
          ),
          itemCount: titles.length,
          itemBuilder: (context, index) {
            return ConvoCard(
              title: titles[index],
              titleTrans: titlesTrans[index],
              conversation: convos[index],
              convoTrans: convosTrans[index],
              controller: controller,
              index: index,
            );
          },
        ),
      ),
    );
  }
}
