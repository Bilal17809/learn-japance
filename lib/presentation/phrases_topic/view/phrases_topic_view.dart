import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/theme/theme.dart';
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
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.secondaryIcon(context),
              ),
            );
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
                            itemCount:
                                data.length +
                                (controller.currentIndex <
                                        controller.topics.length
                                    ? 1
                                    : 0) +
                                1,
                            itemBuilder: (context, index) {
                              if (index == 3) return NativeAdWidget();
                              final dataIndex = index > 3 ? index - 1 : index;
                              if (dataIndex >= data.length) {
                                return SizedBox(
                                  height: 60,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.secondaryIcon(context),
                                    ),
                                  ),
                                );
                              }
                              return TopicCard(
                                topic: data[dataIndex],
                                index: dataIndex,
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
