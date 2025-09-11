import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/theme/theme.dart';
import '../../controller/phrases_topic_controller.dart';
import '/core/constants/constants.dart';
import '/core/common_widgets/common_widgets.dart';
import '/data/models/models.dart';
import '/presentation/phrases/view/phrases_view.dart';

class TopicCard extends StatelessWidget {
  final PhrasesTopicModel topic;
  final int index;
  const TopicCard({super.key, required this.topic, required this.index});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PhrasesTopicController>();
    return ClipPath(
      clipper: TicketClipper(),
      child: GestureDetector(
        onTap:
            () => Get.to(
              () => PhrasesView(topicId: topic.id, description: topic.desc),
            ),
        child: Container(
          margin: const EdgeInsets.only(bottom: kElementGap),
          padding: const EdgeInsets.all(kBodyHp),
          decoration: AppDecorations.rounded(context),
          child: Obx(() {
            final translated = controller.topicTranslations[index];
            return ListTile(
              title: Text(
                topic.title,
                style: titleMediumStyle.copyWith(fontWeight: FontWeight.w500),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: kGap / 1.5),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    translated,
                    style: titleMediumStyle.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
