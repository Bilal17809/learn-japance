import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_japan/core/common_widgets/common_widgets.dart';
import 'package:learn_japan/core/local_storage/local_storage.dart';
import 'package:learn_japan/core/theme/app_colors.dart';
import 'package:toastification/toastification.dart';
import '/data/models/models.dart';
import '/core/services/services.dart';
import '/presentation/splash/controller/splash_controller.dart';

class TranslatorController extends GetxController {
  final SplashController splashController = Get.find<SplashController>();
  final TranslationService translationService = TranslationService();
  final LocalStorage _localStorage = LocalStorage();
  final TextEditingController inputController = TextEditingController();
  var sourceLanguage = Rxn<LanguageModel>();
  var targetLanguage = Rxn<LanguageModel>();
  var allLanguages = <LanguageModel>[].obs;
  var inputText = "".obs;
  var translatedText = "".obs;
  var isTranslating = false.obs;
  final rtlLng = ["ar", "ur"];
  var isSourceRtl = false.obs;
  var isTargetRtl = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLngData();
  }

  void fetchLngData() {
    if (splashController.lngData != null) {
      allLanguages.value = splashController.lngData!;
    }
    sourceLanguage.value = allLanguages.firstWhereOrNull(
      (lng) => lng.name == "English",
    );
    targetLanguage.value = allLanguages.firstWhereOrNull(
      (lng) => lng.name == "Japanese",
    );
    _checkRtl();
  }

  Future<void> translateInput() async {
    if (inputText.value.isEmpty) {
      SimpleToast.showCustomToast(
        context: Get.context!,
        message: 'Input field cannot be empty',
        type: ToastificationType.error,
        primaryColor: AppColors.kRed,
        icon: Icons.error_outline,
      );
      return;
    } else {
      isTranslating.value = true;
      try {
        final result = await translationService.translateText(
          inputText.value,
          targetLanguage: targetLanguage.value!.code,
        );
        translatedText.value = result;
      } catch (e) {
        translatedText.value = "Translation failed: $e";
      } finally {
        isTranslating.value = false;
      }
    }
  }

  void _checkRtl() {
    if (sourceLanguage.value != null &&
        rtlLng.contains(sourceLanguage.value!.code)) {
      isSourceRtl.value = true;
    } else {
      isSourceRtl.value = false;
    }

    if (targetLanguage.value != null &&
        rtlLng.contains(targetLanguage.value!.code)) {
      isTargetRtl.value = true;
    } else {
      isTargetRtl.value = false;
    }
  }

  void setSource(LanguageModel lng) {
    sourceLanguage.value = lng;
    _checkRtl();
  }

  void setTarget(LanguageModel lng) {
    targetLanguage.value = lng;
    _checkRtl();
  }
}
