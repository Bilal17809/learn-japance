import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '/core/utils/utils.dart';
import '/presentation/learn_japanese/controller/learn_japanese_controller.dart';
import '/core/common_widgets/common_widgets.dart';
import '/core/theme/theme.dart';
import '/presentation/Start_learning/view/start_learning_view.dart';
import '/core/constants/constants.dart';

class LearnJapaneseView extends StatelessWidget {
  const LearnJapaneseView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LearnJapaneseController>();
    return Scaffold(
      appBar: TitleBar(title: 'Learn Japanese'),
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
                Image.asset(Assets.heroImg, width: context.screenWidth * 0.41),
                const Gap(kElementGap),
                Expanded(child: _MenuGrid()),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class _MenuGrid extends StatelessWidget {
  const _MenuGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(kBodyHp),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: kGap,
        crossAxisSpacing: kGap,
        childAspectRatio: 1,
      ),
      itemCount: ItemsUtil.homeItems.length,
      itemBuilder: (context, index) {
        final item = ItemsUtil.homeItems[index];
        return GestureDetector(
          onTap: () {},
          child: ItemCard(
            item: item,
            width: primaryIcon(context) * 5,
            // height: primaryIcon(context) * 5,
          ),
        );
      },
    );
  }
}

class LearnJapaneseCard extends StatelessWidget {
  final LearnJapaneseModel item;

  const LearnJapaneseCard({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => StartLearningView());
      },
      child: Container(
        decoration: AppDecorations.rounded(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: AppDecorations.roundedIcon(context),
              child: SizedBox(height: 35, width: 35, child: item.image),
            ),
            const SizedBox(height: 8),
            Text(
              item.label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w600, // semiBold
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final List<LearnJapaneseModel> learnJapaneseItems = [
  LearnJapaneseModel(
    image: Image.asset("images/hand-shake.png"),
    label: "Greetings",
  ),
  LearnJapaneseModel(
    image: Image.asset("images/chat.png"),
    label: "Conversation",
  ),
  LearnJapaneseModel(
    image: Image.asset("images/calculator.png"),
    label: "Numbers",
  ),
  LearnJapaneseModel(
    image: Image.asset("images/calendar.png"),
    label: "Time & Date",
  ),
  LearnJapaneseModel(
    image: Image.asset("images/road-map.png"),
    label: "Direction",
  ),
  LearnJapaneseModel(
    image: Image.asset("images/delivery-truck.png"),
    label: "Transportation",
  ),
];

class LearnJapaneseModel {
  final Image image;
  final String label;
  LearnJapaneseModel({required this.image, required this.label});
}
