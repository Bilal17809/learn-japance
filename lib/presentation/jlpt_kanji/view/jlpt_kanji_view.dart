import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/theme/theme.dart';
import '/core/common_widgets/common_widgets.dart';
import 'widgets/kanji_box.dart';
import '/presentation/jlpt_kanji/controller/jlpt_kanji_controller.dart';
import '/core/constants/constants.dart';
import '/ad_manager/ad_manager.dart';

class JlptKanjiView extends StatelessWidget {
  final int jlptLevel;
  const JlptKanjiView({super.key, required this.jlptLevel});
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<InterstitialAdManager>().checkAndDisplayAd();
    });
    final controller = Get.find<JlptKanjiController>();
    return Obx(() {
      if (controller.isLoading.value) {
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(
              color: AppColors.secondaryIcon(context),
            ),
          ),
        );
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
        bottomNavigationBar:
            Get.find<InterstitialAdManager>().isShow.value
                ? const SizedBox()
                : const BannerAdWidget(),
      );
    });
  }
}
