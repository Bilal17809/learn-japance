import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/theme/theme.dart';
import '../controller/phrases_topic_controller.dart';
import '/core/constants/constants.dart';
import '/core/common_widgets/common_widgets.dart';
import '/data/models/models.dart';
import '../../phrases/view/phrases_view.dart';

class PhrasesTopicView extends StatelessWidget {
  const PhrasesTopicView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PhrasesTopicController>();
    final searchController = TextEditingController();

    return Scaffold(
      appBar: TitleBar(title: 'Phrases'),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = controller.getFilteredTopics();

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kBodyHp,
                  vertical: kGap,
                ),
                child: SearchBarField(
                  controller: searchController,
                  onSearch: (value) => controller.searchQuery.value = value,
                ),
              ),
              Expanded(
                child:
                    data.isEmpty
                        ? LottieWidget()
                        : ListView.builder(
                          padding: const EdgeInsets.symmetric(
                            horizontal: kBodyHp,
                          ),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final topic = data[index];
                            return _TopicCard(topic: topic);
                          },
                        ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class _TopicCard extends StatelessWidget {
  final PhrasesTopicModel topic;
  const _TopicCard({required this.topic});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PhrasesTopicController>();
    final index = controller.topics.indexOf(topic);

    return GestureDetector(
      onTap:
          () => Get.to(
            () => PhrasesView(topicId: topic.id, description: topic.desc),
          ),
      child: Container(
        margin: const EdgeInsets.only(bottom: kElementGap),
        padding: const EdgeInsets.all(kBodyHp),
        decoration: AppDecorations.simpleDecor(context),
        child: Obx(() {
          final translated = controller.topicTranslations[index];
          return ListTile(
            title: Align(
              alignment: Alignment.topLeft,
              child: Text(
                topic.title,
                style: titleMediumStyle.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: kGap / 1.5),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  translated,
                  style: titleMediumStyle.copyWith(fontWeight: FontWeight.w500),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
