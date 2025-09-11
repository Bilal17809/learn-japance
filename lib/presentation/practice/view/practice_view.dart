import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '/core/common_widgets/common_widgets.dart';
import '/presentation/practice/controller/practice_controller.dart';
import '/core/constants/constants.dart';
import '/core/theme/theme.dart';

class PracticeView extends StatelessWidget {
  final String category;
  final String japCategory;
  final int topicId;

  PracticeView({
    super.key,
    required this.category,
    required this.japCategory,
    required this.topicId,
  });

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PracticeController>();
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
                          padding: const EdgeInsets.all(24),
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
                    index < data.length - 1
                        ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
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
                                icon: Icons.forward,
                                label: 'Skip',
                              ),
                            ),
                            const Gap(kGap),
                            Flexible(
                              child: AppElevatedButton(
                                onPressed: () {},
                                icon: Icons.start,
                                label: 'Start',
                                width: double.infinity,
                              ),
                            ),
                          ],
                        )
                        : const SizedBox.shrink(),
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
