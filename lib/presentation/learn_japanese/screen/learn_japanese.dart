import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_japan/core/theme/app_decorations.dart';
import '../../../core/theme/theme.dart';
import '../../Start_learning/screen/start_learning.dart';
import '/core/constants/constants.dart';

class LearnJapanese extends StatelessWidget {
  const LearnJapanese({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset("images/2x/four-circle.png"),
        title: const Text(
          "LEARN JAPANESE",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600, // semiBold
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),

            Image.asset("images/Group 1.png", height: 180),

            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: kBodyHp),
                child: const Learnjapance(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Learnjapance extends StatelessWidget {
  const Learnjapance({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kBodyHp),
      child: GridView.builder(
        itemCount: learnJapaneseItems.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 30,
          mainAxisSpacing: 16,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          final item = learnJapaneseItems[index];
          return LearnJapaneseCard(item: item);
        },
      ),
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
        Get.to(() => StartLearning());
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
