import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
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
            physics: NeverScrollableScrollPhysics(),
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
                      child: Center(
                        child: Container(
                          width: double.infinity,
                          decoration: AppDecorations.simpleDecor(context),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                data[index].english,
                                textAlign: TextAlign.center,
                                style: headlineSmallStyle,
                              ),
                              const Gap(kBodyHp),
                              Text(
                                data[index].japanese,
                                textAlign: TextAlign.center,
                                style: titleLargeStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Gap(kElementGap),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        index < data.length - 1
                            ? Flexible(
                              child: AppElevatedButton(
                                onPressed: () {
                                  if (index < data.length - 1) {
                                    _pageController.nextPage(
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      curve: Curves.easeInOut,
                                    );
                                  }
                                },
                                width: double.infinity,
                                icon: Icons.keyboard_double_arrow_right,
                                label: 'Skip',
                              ),
                            )
                            : const SizedBox.shrink(),
                        const Gap(kGap),
                        Flexible(
                          child: AppElevatedButton(
                            onPressed:
                                () => Get.to(
                                  () => PracticeView(
                                    data: controller.data.toList(),
                                    category: category,
                                    japCategory: japCategory,
                                    startIndex: index,
                                  ),
                                ),
                            icon: Icons.rocket_launch,
                            label: 'Start',
                            width: double.infinity,
                          ),
                        ),
                      ],
                    ),
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
