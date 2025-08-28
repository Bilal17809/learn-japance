import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/common/app_exceptions.dart';
import '/core/common_widgets/common_widgets.dart';
import '/data/models/models.dart';
import '/core/services/services.dart';
import '/core/utils/utils.dart';

class TranslatorController extends GetxController {
  final LanguageService _lngService;
  final TranslationService _translationService;
  final TranslatorStorageService _storageService;
  final SpeechService _speechService;

  TranslatorController({
    required LanguageService lngService,
    required TranslationService translationService,
    required TranslatorStorageService storageService,
    required SpeechService speechService,
  }) : _lngService = lngService,
       _translationService = translationService,
       _storageService = storageService,
       _speechService = speechService;

  final inputController = TextEditingController();
  final isLoading = true.obs;
  final sourceLanguage = Rxn<LanguageModel>();
  final targetLanguage = Rxn<LanguageModel>();
  final allLanguages = <LanguageModel>[].obs;
  final inputText = "".obs;
  final translations = <TransResultModel>[].obs;
  final isTranslating = false.obs;
  final isSourceRtl = false.obs;
  final isTargetRtl = false.obs;
  final isSpeaking = false.obs;
  final favorites = <TransResultModel>[].obs;

  static const rtlLng = ["ar", "ur"];

  @override
  void onInit() {
    super.onInit();
    fetchLngData();
    loadFav();
    _loadTranslations();
  }

  Future<void> fetchLngData() async {
    isLoading.value = true;
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      allLanguages.value = await _lngService.loadLanguages();

      final savedSource = await _storageService.getSourceLanguage();
      final savedTarget = await _storageService.getTargetLanguage();

      sourceLanguage.value =
          _findLng(savedSource) ??
          allLanguages.firstWhere((lng) => lng.name == "English");
      targetLanguage.value =
          _findLng(savedTarget) ??
          allLanguages.firstWhere((lng) => lng.name == "Japanese");
      _checkRtl();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _loadTranslations() async {
    translations.value = await _storageService.getTranslations();
  }

  LanguageModel? _findLng(String? name) =>
      name == null ? null : allLanguages.firstWhere((lng) => lng.name == name);

  Future<void> translateInput() async {
    if (inputText.value.isEmpty) {
      ToastUtil().showErrorToast('Input field cannot be empty');
      return;
    }

    isTranslating.value = true;
    final currentSourceRtl = isSourceRtl.value;
    final currentTargetRtl = isTargetRtl.value;

    try {
      final result = await _translationService.translateText(
        inputText.value,
        targetLanguage: targetLanguage.value!.code,
      );

      final newResult = TransResultModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        input: inputText.value,
        output: result,
        isSourceRtl: currentSourceRtl,
        isTargetRtl: currentTargetRtl,
      );

      translations.add(newResult);
      await _storageService.saveTranslation(newResult);

      Get.find<TtsService>().speak(newResult.output, targetLanguage.value);
    } catch (e) {
      translations.add(
        TransResultModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          input: inputText.value,
          output: "${AppExceptions().failToTranslate}: $e",
          isSourceRtl: currentSourceRtl,
          isTargetRtl: currentTargetRtl,
        ),
      );
    } finally {
      isTranslating.value = false;
    }
  }

  void _checkRtl() {
    isSourceRtl.value = rtlLng.contains(sourceLanguage.value?.code);
    isTargetRtl.value = rtlLng.contains(targetLanguage.value?.code);
  }

  Future<void> _setLanguage(LanguageModel lng, bool isSource) async {
    if (isSource) {
      sourceLanguage.value = lng;
      inputController.clear();
      inputText.value = '';
      await _storageService.setSourceLanguage(lng.name);
    } else {
      targetLanguage.value = lng;
      await _storageService.setTargetLanguage(lng.name);
    }
    _checkRtl();
  }

  void setSource(LanguageModel lng) => _setLanguage(lng, true);
  void setTarget(LanguageModel lng) => _setLanguage(lng, false);

  Future<void> handleSpeechInput() async {
    try {
      final locale = sourceLanguage.value?.ttsCode;
      String? recognized;

      if (Platform.isAndroid) {
        await _speechService.startSpeechToText(locale: locale);
        recognized = _speechService.getRecognizedText();
      } else {
        recognized = await showDialog<String>(
          context: Get.context!,
          builder: (_) => const SpeechDialog(),
        );
      }

      if (recognized?.isNotEmpty ?? false) {
        inputController.text = recognized!;
        inputText.value = recognized;
      }
    } catch (e) {
      ToastUtil().showErrorToast('${AppExceptions().failToTranslate}: $e');
    } finally {
      translateInput();
    }
  }

  Future<void> loadFav() async {
    favorites.value = await _storageService.getFavorites();
  }

  Future<void> toggleFav(String id) async {
    final t = translations.firstWhereOrNull((t) => t.id == id);
    if (t == null) return;

    if (isFav(id)) {
      favorites.removeWhere((f) => f.id == id);
    } else {
      favorites.add(t);
    }
    await _storageService.saveFavorites(favorites);
    favorites.refresh();
  }

  bool isFav(String id) => favorites.any((f) => f.id == id);

  Future<void> remove(String id) async {
    translations.removeWhere((t) => t.id == id);

    await _storageService.removeTranslation(id);
    translations.refresh();
  }

  Future<void> removeFav(String id) async {
    favorites.removeWhere((f) => f.id == id);
    await _storageService.saveFavorites(favorites);
    favorites.refresh();
  }

  @override
  void onClose() {
    inputController.dispose();
    Get.find<TtsService>().stop();
    super.onClose();
  }
}
