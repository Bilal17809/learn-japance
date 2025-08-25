import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '/data/models/models.dart';
import '/core/services/services.dart';

class TranslatorController extends GetxController {
  final languageService = Get.find<LanguageService>();
  var sourceLanguage = Rxn<LanguageModel>();
  var targetLanguage = Rxn<LanguageModel>();
  var isLoading = true.obs;
  var allLanguages = <LanguageModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadLanguages();
  }

  Future<void> loadLanguages() async {
    try {
      isLoading.value = true;
      allLanguages.value = await languageService.loadLanguages();
      debugPrint(
        "///////////////////////Languages loaded: ${allLanguages.length}",
      );
      sourceLanguage.value = allLanguages.firstWhereOrNull(
        (lng) => lng.name == "English",
      );
      targetLanguage.value = allLanguages.firstWhereOrNull(
        (lng) => lng.name == "Japanese",
      );
    } finally {
      isLoading.value = false;
    }
  }

  void setSource(LanguageModel lng) => sourceLanguage.value = lng;
  void setTarget(LanguageModel lng) => targetLanguage.value = lng;
}
