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
          final data =
              controller
                  .getFilteredTopics()
                  .asMap()
                  .entries
                  .where(
                    (entry) =>
                        controller.topicTranslations[entry.key].isNotEmpty,
                  )
                  .map((entry) => entry.value)
                  .toList();

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
                        : NotificationListener<ScrollNotification>(
                          onNotification: (scrollInfo) {
                            if (!controller.translationsLoading.value &&
                                scrollInfo.metrics.pixels >=
                                    scrollInfo.metrics.maxScrollExtent - 100) {
                              controller.translateNextBatch();
                            }
                            return false;
                          },

                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(
                              horizontal: kBodyHp,
                            ),
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              final topic = data[index];
                              if (index == controller.currentIndex - 1 &&
                                  controller.translationsLoading.value) {
                                return Column(
                                  children: [
                                    _TopicCard(topic: topic, index: index),
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                  ],
                                );
                              }
                              return _TopicCard(topic: topic, index: index);
                            },
                          ),
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
  final int index;
  const _TopicCard({required this.topic, required this.index});

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
