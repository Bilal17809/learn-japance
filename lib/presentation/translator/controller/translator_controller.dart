import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_japan/core/local_storage/local_storage.dart';
import '/core/common/app_exceptions.dart';
import '/core/common_widgets/common_widgets.dart';
import '/core/theme/theme.dart';
import 'package:toastification/toastification.dart';
import '/data/models/models.dart';
import '/core/services/services.dart';

class TranslatorController extends GetxController {
  final LanguageService _lngService;
  final TranslationService _translationService;
  final LocalStorage _localStorage;
  final SpeechService _speechService;

  TranslatorController({
    required LanguageService lngService,
    required TranslationService translationService,
    required LocalStorage localStorage,
    required SpeechService speechService,
  }) : _lngService = lngService,
       _translationService = translationService,
       _localStorage = localStorage,
       _speechService = speechService;

  final TextEditingController inputController = TextEditingController();
  var isLoading = true.obs;
  var sourceLanguage = Rxn<LanguageModel>();
  var targetLanguage = Rxn<LanguageModel>();
  var allLanguages = <LanguageModel>[].obs;
  var inputText = "".obs;
  var translatedText = "".obs;
  var isTranslating = false.obs;
  final rtlLng = ["ar", "ur"];
  var isSourceRtl = false.obs;
  var isTargetRtl = false.obs;
  var isSpeaking = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLngData();
  }

  void fetchLngData() async {
    isLoading.value = true;
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      allLanguages.value = await _lngService.loadLanguages();
      final savedSource = await _localStorage.getString('sourceLanguage');
      final savedTarget = await _localStorage.getString('targetLanguage');
      if (savedSource != null && savedTarget != null) {
        sourceLanguage.value = allLanguages.firstWhere(
          (lng) => lng.name == savedSource,
          orElse: () => allLanguages.first,
        );
        targetLanguage.value = allLanguages.firstWhere(
          (lng) => lng.name == savedTarget,
          orElse: () => allLanguages[1],
        );
      } else {
        sourceLanguage.value = allLanguages.firstWhere(
          (lng) => lng.name == "English",
        );
        targetLanguage.value = allLanguages.firstWhere(
          (lng) => lng.name == "Japanese",
        );
      }

      _checkRtl();
    } finally {
      isLoading.value = false;
    }
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
        final result = await _translationService.translateText(
          inputText.value,
          targetLanguage: targetLanguage.value!.code,
        );
        translatedText.value = result;
      } catch (e) {
        translatedText.value = "${AppExceptions().failToTranslate}: $e";
      } finally {
        isTranslating.value = false;
        Get.find<TtsService>().speak(
          translatedText.value,
          targetLanguage.value,
        );
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

  void setSource(LanguageModel lng) async {
    sourceLanguage.value = lng;
    await _localStorage.setString('sourceLanguage', lng.name);
    _checkRtl();
    inputController.clear();
    inputText.value = '';
  }

  void setTarget(LanguageModel lng) async {
    targetLanguage.value = lng;
    await _localStorage.setString('targetLanguage', lng.name);
    _checkRtl();
    translatedText.value = '';
  }

  void handleSpeechInput() async {
    try {
      final locale = sourceLanguage.value?.ttsCode;
      if (Platform.isAndroid) {
        await _speechService.startSpeechToText(locale: locale);
        final recognizedText = _speechService.getRecognizedText();
        if (recognizedText.isNotEmpty) {
          inputController.text = recognizedText;
          inputText.value = recognizedText;
        }
      } else {
        final result = await showDialog<String>(
          context: Get.context!,
          builder: (context) => const SpeechDialog(),
        );
        if (result != null && result.isNotEmpty) {
          inputController.text = result;
          inputText.value = result;
        }
      }
    } catch (e) {
      SimpleToast.showCustomToast(
        context: Get.context!,
        message: '${AppExceptions().failToTranslate}: $e',
        type: ToastificationType.error,
        primaryColor: AppColors.kRed,
        icon: Icons.error_outline,
      );
    } finally {
      translateInput();
    }
  }

  @override
  void onClose() {
    inputController.dispose();
    Get.find<TtsService>().stop();
    super.onClose();
  }
}
