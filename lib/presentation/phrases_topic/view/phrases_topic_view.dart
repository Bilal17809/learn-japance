import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/presentation/phrases_topic/controller/phrases_topic_controller.dart';
import '/core/constants/constants.dart';
import '/core/common_widgets/common_widgets.dart';
import 'widgets/topic_card.dart';
import '/ad_manager/ad_manager.dart';

class PhrasesTopicView extends StatelessWidget {
  const PhrasesTopicView({super.key});
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<InterstitialAdManager>().checkAndDisplayAd();
    });
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
                    (data.isEmpty && !controller.translationsLoading.value)
                        ? LottieWidget()
                        : NotificationListener<ScrollNotification>(
                          onNotification: (scrollInfo) {
                            if (!controller.translationsLoading.value &&
                                controller.currentIndex <
                                    controller.topics.length &&
                                scrollInfo.metrics.pixels >=
                                    scrollInfo.metrics.maxScrollExtent - 100) {
                              controller.translateBatch();
                            }
                            return false;
                          },
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(
                              horizontal: kBodyHp,
                            ),
                            itemCount: data.length + 1,
                            itemBuilder: (context, index) {
                              if (index == data.length) {
                                if (controller.translationsLoading.value) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (controller.currentIndex <
                                    controller.topics.length) {
                                  return const SizedBox(
                                    height: 60,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                } else {
                                  return const SizedBox.shrink();
                                }
                              }
                              if (index == 3) {
                                return NativeAdWidget();
                              }
                              return TopicCard(
                                topic: data[index],
                                index: index,
                              );
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
