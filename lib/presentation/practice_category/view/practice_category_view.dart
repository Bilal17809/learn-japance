import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:learn_japan/presentation/practice/view/practice_view.dart';
import '/presentation/practice_category/controller/practice_category_controller.dart';
import '/core/utils/utils.dart';
import '/core/common_widgets/common_widgets.dart';
import '/core/constants/constants.dart';
import '/data/models/learn_topic_model.dart';

class PracticeCategoryView extends StatelessWidget {
  const PracticeCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PracticeCategoryController>();
    return Scaffold(
      appBar: TitleBar(title: 'Practice'),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        final data = controller.topics;
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(kBodyHp),
            child: Column(
              children: [
                const Gap(kElementGap),
                Image.asset(
                  Assets.heroImage,
                  width: context.screenWidth * 0.41,
                ),
                const Gap(kElementGap),
                Expanded(child: _MenuGrid(data: data)),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class _MenuGrid extends StatelessWidget {
  final List<LearnTopicModel> data;

  const _MenuGrid({required this.data});

  @override
  Widget build(BuildContext context) {
    final item = ItemsUtil.learnItems;
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: kGap,
        crossAxisSpacing: kGap,
        childAspectRatio: 1,
      ),
      itemCount: item.length,
      itemBuilder: (context, index) {
        return CategoryCard(
          isPractice: true,
          category: data[index].japanese,
          translatedCategory: data[index].english,
          item: item[index],
          onTap:
              () => Get.to(
                () => PracticeView(
                  topicId: index,
                  japCategory: data[index].japanese,
                  category: data[index].english,
                ),
              ),
        );
      },
    );
  }
}
