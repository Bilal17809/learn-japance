import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_japan/core/utils/assets_util.dart';
import 'package:lottie/lottie.dart';
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
                  controller: controller.searchController,
                  onSearch: (value) => controller.searchQuery.value = value,
                ),
              ),
              Expanded(
                child:
                    data.isEmpty
                        ? Center(
                          child: Lottie.asset(
                            Assets.searchError,
                            width: context.screenWidth * 0.41,
                          ),
                        )
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
        decoration: AppDecorations.simpleDecor(
          context,
        ).copyWith(borderRadius: BorderRadius.circular(kBorderRadius)),
        child: Obx(() {
          final translated =
              index < controller.topicTranslations.length
                  ? controller.topicTranslations[index]
                  : '翻訳中...';
          return ListTile(
            title: Align(
              alignment: Alignment.topLeft,
              child: Text(topic.title),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: kGap / 1.5),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text(translated),
              ),
            ),
          );
        }),
      ),
    );
  }
}
