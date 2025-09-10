import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/constants/constants.dart';
import '/core/theme/theme.dart';
import '/presentation/jlpt_kanji/view/jlpt_kanji_view.dart';
import '/data/models/hiragana_model.dart';
import '/data/models/katakana_model.dart';
import '/presentation/jws/controller/jws_controller.dart';
import 'character_section.dart';

class TabViewSections extends StatelessWidget {
  const TabViewSections({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<JwsController>();
    return TabBarView(
      physics: NeverScrollableScrollPhysics(),
      children: [
        _HiraganaSection(controller: controller),
        _KatakanaSection(controller: controller),
        _KanjiSection(controller: controller),
      ],
    );
  }
}

class _HiraganaSection extends StatelessWidget {
  final JwsController controller;

  const _HiraganaSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    final hiragana = controller.hiraganaData.value?.hiragana;
    if (hiragana == null) return const SizedBox();

    final sections = [
      {"title": "Gojuon", "items": hiragana.gojuon},
      {"title": "Dakuten", "items": hiragana.dakuten},
      {"title": "Yoon", "items": hiragana.yoon},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(kElementGap),
      itemCount: sections.length,
      itemBuilder: (_, index) {
        final section = sections[index];
        return CharacterSection(
          title: section["title"] as String,
          items: section["items"] as List<HiraganaItem>,
        );
      },
    );
  }
}

class _KatakanaSection extends StatelessWidget {
  final JwsController controller;

  const _KatakanaSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    final katakana = controller.katakanaData.value?.katakana;
    if (katakana == null) return const SizedBox();

    final sections = [
      {"title": "Gojuon", "items": katakana.gojuon},
      {"title": "Dakuten", "items": katakana.dakuten},
      {"title": "Yoon", "items": katakana.yoon},
      {"title": "Loanwords", "items": katakana.loanwords},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(kElementGap),
      itemCount: sections.length,
      itemBuilder: (_, index) {
        final section = sections[index];
        return CharacterSection(
          title: section["title"] as String,
          items: section["items"] as List<KatakanaItem>,
        );
      },
    );
  }
}

class _KanjiSection extends StatelessWidget {
  final JwsController controller;

  const _KanjiSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    final jlptLevels = [4, 3, 2, 1];

    return ListView.builder(
      padding: const EdgeInsets.all(kBodyHp),
      itemCount: jlptLevels.length,
      itemBuilder: (_, index) {
        final jlpt = jlptLevels[index];
        return GestureDetector(
          onTap: () {
            Get.to(() => JlptKanjiView(jlptLevel: jlpt));
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: kGap),
            padding: const EdgeInsets.all(kBodyHp),
            decoration: AppDecorations.rounded(
              context,
            ).copyWith(border: Border.all(color: AppColors.kBlack, width: 1)),
            child: Center(child: Text("JLPT N$jlpt", style: titleLargeStyle)),
          ),
        );
      },
    );
  }
}
