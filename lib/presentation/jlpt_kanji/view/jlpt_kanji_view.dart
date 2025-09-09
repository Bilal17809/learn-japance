import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/common_widgets/common_widgets.dart';
import 'widgets/kanji_box.dart';
import '/presentation/jlpt_kanji/controller/jlpt_kanji_controller.dart';
import '/core/constants/constants.dart';

class JlptKanjiView extends StatelessWidget {
  const JlptKanjiView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<JlptKanjiController>();
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      return Scaffold(
        appBar: TitleBar(title: 'JLPT'),
        body: SafeArea(
          child: ListView.builder(
            padding: const EdgeInsets.all(kBodyHp),
            itemCount: controller.kanjiData.length,
            itemBuilder: (_, index) {
              final item = controller.kanjiData[index];
              return KanjiBox(item: item);
            },
          ),
        ),
      );
    });
  }
}
