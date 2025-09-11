import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '/presentation/practice_category/view/practice_category_view.dart';
import '/data/models/models.dart';
import '/presentation/dialogue_category/view/dialogue_category_view.dart';
import '/core/common_widgets/common_widgets.dart';
import '/presentation/phrases_topic/view/phrases_topic_view.dart';
import '/presentation/dictionary/view/dictionary_view.dart';
import '/core/utils/utils.dart';
import '/presentation/translator/view/translator_view.dart';
import '/presentation/grammar_type/view/grammar_type_view.dart';
import '/presentation/learn_category/view/learn_category_view.dart';
import '/core/constants/constants.dart';
import '/core/theme/theme.dart';

class MenuList extends StatelessWidget {
  const MenuList({super.key});

  @override
  Widget build(BuildContext context) {
    final double itemHeight =
        primaryIcon(context) +
        (kBodyHp * 2) +
        kGap +
        bodyMediumStyle.fontSize! * 3;

    return SizedBox(
      height: itemHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: ItemsUtil.homeItems.length,
        padding: const EdgeInsets.symmetric(horizontal: kBodyHp),
        itemBuilder: (context, index) {
          final item = ItemsUtil.homeItems[index];
          return Padding(
            padding: EdgeInsets.only(
              right: index == ItemsUtil.homeItems.length - 1 ? 0 : kGap,
            ),
            child: GestureDetector(
              onTap: () {
                switch (index) {
                  case 0:
                    Get.to(() => LearnCategoryView());
                    break;
                  case 1:
                    Get.to(() => DictionaryView());
                    break;
                  case 2:
                    Get.to(() => TranslatorView());
                    break;
                  case 3:
                    Get.to(() => GrammarTypeView());
                    break;
                  case 4:
                    Get.to(() => DialogueCategoryView());
                    break;
                  case 5:
                    Get.to(() => PhrasesTopicView());
                    break;
                  case 6:
                    Get.to(() {});
                    break;
                  case 7:
                    Get.to(() => PracticeCategoryView());
                    break;
                  case 8:
                    Get.to(() {});
                    break;
                }
              },
              child: _ItemCard(item: item),
            ),
          );
        },
      ),
    );
  }
}

class _ItemCard extends StatelessWidget {
  final ItemsModel item;

  const _ItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: ImageActionButton(
            assetPath: item.assetPath,
            backgroundColor: AppColors.container(context),
            padding: const EdgeInsets.all(kBodyHp),
            size: primaryIcon(context),
            color: AppColors.primary(context),
          ),
        ),
        const Gap(kGap),
        Flexible(
          child: SizedBox(
            width: 70,
            child: Text(
              item.label ?? '',
              textAlign: TextAlign.center,
              style: bodySmallStyle.copyWith(fontWeight: FontWeight.w600),
              maxLines: 2,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
