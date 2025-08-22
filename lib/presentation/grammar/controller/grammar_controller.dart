import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/data/models/models.dart';
import '/core/services/translation_service.dart';
import '/presentation/splash/controller/splash_controller.dart';

class GrammarController extends GetxController {
  final SplashController splashController = Get.find<SplashController>();
  final TranslationService translationService = TranslationService();
  final RxMap<String, String> translationCache = <String, String>{}.obs;
  final RxMap<String, bool> translatingStates = <String, bool>{}.obs;
  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  Future<void> translateText(String key, String text) async {
    if (translationCache.containsKey(key)) return;
    translatingStates[key] = true;
    try {
      final translation = await translationService.translateText(text);
      translationCache[key] = translation;
    } catch (e) {
      translationCache[key] = "Translation failed";
    } finally {
      translatingStates[key] = false;
    }
  }

  Future<void> translateAll(GrammarModel item) async {
    final textsToTranslate = [
      item.category,
      item.description,
      ...item.examples,
    ];
    final translations = await translationService.translateList(
      textsToTranslate,
    );
    await translateText("${item.id}_category", translations[0]);
    await translateText("${item.id}_description", translations[1]);

    for (int i = 0; i < item.examples.length; i++) {
      await translateText("${item.id}_example_$i", translations[i + 2]);
    }
  }

  List<GrammarModel> getFilteredData(String category) {
    final data = splashController.grammarData ?? [];

    final filtered = data.where((item) => item.category == category).toList();

    if (searchQuery.value.isNotEmpty) {
      return filtered
          .where(
            (item) => item.title.toLowerCase().contains(
              searchQuery.value.toLowerCase().trim(),
            ),
          )
          .toList();
    }

    return filtered;
  }
}
