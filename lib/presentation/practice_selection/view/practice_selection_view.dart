import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
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
    final controller = Get.find<PracticeSelectionController>();
    controller.setTopic(topicId);

    return Scaffold(
      appBar: TitleBar(title: '$category - $japCategory'),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
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
                padding: const EdgeInsets.all(20),
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
                                    style: headlineMediumStyle,
                                    textAlign: TextAlign.center,
                                  ),
                                  const Gap(kGap),
                                  Text(
                                    data[index].japanese,
                                    style: headlineLargeStyle,
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
                    NativeAdWidget(),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
