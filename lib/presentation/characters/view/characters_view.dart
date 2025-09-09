import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_japan/core/constants/constants.dart';
import 'package:learn_japan/core/theme/theme.dart';
import '/core/common_widgets/common_widgets.dart';
import '/data/models/hiragana_model.dart';
import '/data/models/katakana_model.dart';
import '/presentation/characters/controller/characters_controller.dart';
import 'widgets/character_section.dart';
import '../../jlpt_kanji/view/widgets/kanji_box.dart';

class CharactersView extends StatelessWidget {
  CharactersView({super.key});
  final controller = Get.find<CharactersController>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: TitleBar(
          title: 'Choose A Category',
          bottom: TabBar(
            tabs: [
              Tab(child: Text("Hiragana", style: titleSmallStyle)),
              Tab(child: Text("Katakana", style: titleSmallStyle)),
              Tab(child: Text("Kanji", style: titleSmallStyle)),
            ],
            isScrollable: false,
          ),
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return SafeArea(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                _HiraganaSection(controller: controller),
                _KatakanaSection(controller: controller),
                _KanjiSection(controller: controller),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _HiraganaSection extends StatelessWidget {
  final CharactersController controller;

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
  final CharactersController controller;

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
  final CharactersController controller;

  const _KanjiSection({required this.controller});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(kBodyHp),
      itemCount: controller.kanjiData.length,
      itemBuilder: (_, index) {
        final item = controller.kanjiData[index];
        return KanjiBox(item: item);
      },
    );
  }
}
