import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/common_widgets/common_widgets.dart';
import 'widgets/kanji_box.dart';
import '/presentation/jlpt_kanji/controller/jlpt_kanji_controller.dart';
import '/core/constants/constants.dart';

class JlptKanjiView extends StatelessWidget {
  final int jlptLevel;

  const JlptKanjiView({super.key, required this.jlptLevel});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<JlptKanjiController>();

    return Obx(() {
      if (controller.isLoading.value) {
        return Scaffold(body: const Center(child: CircularProgressIndicator()));
      }
      final filteredKanji =
          controller.kanjiData.where((k) => k.jlpt == jlptLevel).toList();

      return Scaffold(
        appBar: TitleBar(title: 'JLPT N$jlptLevel'),
        body: SafeArea(
          child: ListView.builder(
            padding: const EdgeInsets.all(kBodyHp),
            itemCount: filteredKanji.length,
            itemBuilder: (_, index) {
              final item = filteredKanji[index];
              return KanjiBox(item: item);
            },
          ),
        ),
      );
    });
  }
}
