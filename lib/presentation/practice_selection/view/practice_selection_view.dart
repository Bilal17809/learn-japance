import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '/ad_manager/ad_manager.dart';
import '/presentation/practice/view/practice_view.dart';
import '/core/common_widgets/common_widgets.dart';
import '/presentation/practice_selection/controller/practice_selection_controller.dart';
import '/core/constants/constants.dart';
import '/core/theme/theme.dart';

class PracticeSelectionView extends StatelessWidget {
  final String category;
  final String japCategory;
  final int topicId;

  PracticeSelectionView({
    super.key,
    required this.category,
    required this.japCategory,
    required this.topicId,
  });

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<InterstitialAdManager>().checkAndDisplayAd();
    });
    final controller = Get.find<PracticeSelectionController>();
    controller.setTopic(topicId);
    return Scaffold(
      appBar: TitleBar(title: '$category - $japCategory'),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.secondaryIcon(context),
            ),
          );
        }
        final data = controller.data;
        return SafeArea(
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              controller.currentPage.value = index;
            },
            itemCount: data.length,
            itemBuilder: (context, index) {
              final progress = (index + 1) / data.length;
              return Padding(
                padding: const EdgeInsets.all(kBodyHp),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        HorizontalProgress(
                          currentStep: (progress * 100).toInt().clamp(0, 100),
                        ),
                        const Gap(kGap),
                        Text(
                          "Lesson ${index + 1} of ${data.length}",
                          style: titleSmallStyle,
                        ),
                      ],
                    ),
                    const Gap(kGap),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(kBodyHp),
                              decoration: AppDecorations.rounded(
                                context,
                              ).copyWith(
                                border: Border.all(
                                  color: AppColors.kGrey.withValues(
                                    alpha: 0.75,
                                  ),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    '${index + 1} of ${data.length}',
                                    style: headlineSmallStyle,
                                    textAlign: TextAlign.center,
                                  ),
                                  const Gap(kGap),
                                  Text(
                                    data[index].japanese,
                                    style:
                                        data[index]
                                                    .japanese
                                                    .characters
                                                    .length <=
                                                20
                                            ? headlineLargeStyle
                                            : headlineMediumStyle,
                                    textAlign: TextAlign.center,
                                  ),
                                  const Gap(kGap),
                                  Text(
                                    data[index].english,
                                    style: titleLargeStyle,
                                    textAlign: TextAlign.center,
                                  ),
                                  const Gap(kGap),
                                  AppElevatedButton(
                                    onPressed:
                                        () => Get.to(
                                          () => PracticeView(
                                            data: controller.data.toList(),
                                            category: category,
                                            japCategory: japCategory,
                                            startIndex: index,
                                          ),
                                        ),
                                    icon: Icons.rocket_launch_rounded,
                                    label: 'Start Now',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(kGap),
                    data[index].japanese.characters.length >= 12
                        ? const SizedBox.shrink()
                        : NativeAdWidget(templateType: TemplateType.medium),
                  ],
                ),
              );
            },
          ),
        );
      }),
      bottomNavigationBar: Obx(() {
        final currentData = controller.data;
        final currentPage = controller.currentPage.value;
        if (currentData.isNotEmpty &&
            currentPage >= 0 &&
            currentPage < currentData.length &&
            currentData[currentPage].japanese.characters.length >= 12) {
          final interstitial = Get.find<InterstitialAdManager>();
          return interstitial.isShow.value
              ? const SizedBox.shrink()
              : const BannerAdWidget();
        } else {
          return const SizedBox.shrink();
        }
      }),
    );
  }
}
