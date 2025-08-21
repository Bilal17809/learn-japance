import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_japan/core/common_widgets/common_widgets.dart';
import '/core/utils/utils.dart';
import '/presentation/Greeting/screen/greeting.dart';
import '/presentation/Start_learning/screen/start_learning.dart';
import '/presentation/Translator/screen/translator.dart';
import '/presentation/grammar_type/view/grammar_type_view.dart';
import '/presentation/learn_japanese/screen/learn_japanese.dart';
import '/core/constants/constants.dart';

class MenuGrid extends StatelessWidget {
  const MenuGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kBodyHp),
        child: GridView.builder(
          itemCount: ItemsUtil.homeItems.length,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: kElementGap,
            mainAxisSpacing: kElementGap,
            childAspectRatio: 0.85,
          ),
          itemBuilder: (context, index) {
            final item = ItemsUtil.homeItems[index];
            return GestureDetector(
              onTap: () {
                switch (index) {
                  case 0:
                    Get.to(() => StartLearning());
                    break;
                  case 1:
                    Get.to(() => LearnJapanese());
                    break;
                  case 2:
                    Get.to(() => Translator());
                    break;
                  case 3:
                    Get.to(() => GrammarTypeView());
                    break;
                  case 4:
                    Get.to(() => Greeting());
                    break;
                  default:
                    break;
                }
              },
              child: ItemCard(item: item),
            );
          },
        ),
      ),
    );
  }
}
