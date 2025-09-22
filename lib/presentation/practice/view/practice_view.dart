import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '/ad_manager/ad_manager.dart';
import '/core/common_widgets/common_widgets.dart';
import '/presentation/practice/controller/practice_controller.dart';
import '/core/constants/constants.dart';
import '/data/models/models.dart';
import 'widgets/fill_bubble_page.dart';
import 'widgets/writing_test_page.dart';
import 'widgets/correct_meaning_page.dart';
import 'widgets/pronunciation_page.dart';
import 'widgets/speech_test_page.dart';

class PracticeView extends StatelessWidget {
  final List<LearnModel> data;
  final String category;
  final String japCategory;
  final int startIndex;
  const PracticeView({
    super.key,
    required this.data,
    required this.category,
    required this.japCategory,
    required this.startIndex,
  });

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<InterstitialAdManager>().checkAndDisplayAd();
    });
    final controller = Get.find<PracticeController>();
    controller.setArguments(data, category, japCategory, startIndex);
    final pageController = PageController();
    return Scaffold(
      appBar: TitleBar(title: '$category - $japCategory'),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  controller.currentPage.value = index;
                },
                children: [
                  PronunciationPage(controller: controller),
                  CorrectMeaningPage(controller: controller),
                  FillBubblePage(controller: controller),
                  SpeechTestPage(controller: controller),
                  WritingTestPage(controller: controller),
                ],
              ),
            ),
            Obx(
              () => Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kBodyHp,
                  vertical: kElementGap,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (controller.currentPage.value > 0)
                      Flexible(
                        child: AppElevatedButton(
                          onPressed: () {
                            if (controller.currentPage.value > 0) {
                              controller.currentPage.value--;
                              pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                          icon: Icons.keyboard_double_arrow_left,
                          label: 'Previous',
                          width: double.infinity,
                        ),
                      ),
                    if (controller.currentPage.value > 0) const Gap(kGap),
                    Flexible(
                      child: AppElevatedButton(
                        onPressed: () {
                          final isLastPage = controller.currentPage.value == 4;
                          final isLastLesson =
                              controller.currentWordIndex.value ==
                              controller.practiceData.length - 1;
                          if (!isLastPage) {
                            controller.currentPage.value++;
                            pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          } else if (!isLastLesson) {
                            controller.saveProgress();
                            controller.currentWordIndex.value++;
                            controller.resetAllPageStates();
                            controller.generateOptionsForBothPages();
                            if (pageController.hasClients) {
                              pageController.jumpToPage(0);
                            }
                          } else {
                            controller.saveProgress();
                            Get.back();
                          }
                        },
                        icon:
                            controller.currentPage.value < 4
                                ? Icons.keyboard_double_arrow_right
                                : (controller.currentWordIndex.value <
                                        controller.practiceData.length - 1
                                    ? Icons.next_plan
                                    : Icons.home),
                        label:
                            controller.currentPage.value < 4
                                ? 'Next'
                                : (controller.currentWordIndex.value <
                                        controller.practiceData.length - 1
                                    ? 'Next Lesson'
                                    : 'Go Home'),
                        width: double.infinity,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(() {
        final interstitial = Get.find<InterstitialAdManager>();
        return interstitial.isShow.value
            ? const SizedBox()
            : const BannerAdWidget();
      }),
    );
  }
}
