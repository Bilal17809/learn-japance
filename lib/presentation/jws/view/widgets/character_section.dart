import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '/core/constants/constants.dart';
import '/core/theme/theme.dart';
import '/data/models/hiragana_model.dart';
import '/data/models/katakana_model.dart';
import '/presentation/jws/controller/jws_controller.dart';

class CharacterSection<T> extends StatelessWidget {
  final String title;
  final List<T> items;

  const CharacterSection({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text('$title:', style: titleMediumStyle),
        ),
        const Gap(kGap),
        Wrap(
          spacing: kGap,
          runSpacing: kGap,
          children:
              items.map((item) {
                if (item is HiraganaItem) {
                  return _CharacterBox(
                    character: item.hiragana,
                    romaji: item.romaji,
                  );
                } else if (item is KatakanaItem) {
                  return _CharacterBox(
                    character: item.katakana,
                    romaji: item.romaji,
                  );
                } else {
                  return const SizedBox();
                }
              }).toList(),
        ),
        const Gap(kBodyHp),
      ],
    );
  }
}

class _CharacterBox extends StatelessWidget {
  final String character;
  final String romaji;

  const _CharacterBox({required this.character, required this.romaji});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<JwsController>();

    return Obx(
      () => GestureDetector(
        onTap: () => controller.onSpeak(character),
        child: Container(
          width: 60,
          height: 80,
          decoration: AppDecorations.rounded(context).copyWith(
            border: Border.all(color: AppColors.kBlack, width: 1),
            color: controller.getBoxColor(character),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(child: Text(character, style: titleLargeStyle)),
              const Gap(kGap / 2),
              Flexible(child: Text(romaji, style: titleSmallStyle)),
            ],
          ),
        ),
      ),
    );
  }
}
