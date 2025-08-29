import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/local_storage/local_storage.dart';
import '/data/models/models.dart';
import '/core/common/app_exceptions.dart';
import '/core/services/services.dart';

class ConvoCatController extends GetxController {
  final ConvoDbService _convoDbService;
  final TranslationService _translationService;
  final LocalStorage _localStorage;

  ConvoCatController({
    required ConvoDbService convoDbService,
    required TranslationService translationService,
    required LocalStorage localStorage,
  }) : _convoDbService = convoDbService,
       _translationService = translationService,
       _localStorage = localStorage;

  static const String _translationCacheKey = "convo_translations";
  final isLoading = true.obs;
  var cat = <ConvoModel>[].obs;
  var uniqueCat = <String>[].obs;
  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;
  var translationLoading = true.obs;
  var catTranslations = <String>[].obs;

  @override
  onInit() {
    super.onInit();
    _fetchCat();
  }

  Future<void> _fetchCat() async {
    isLoading.value = true;
    try {
      await Future.delayed(const Duration(milliseconds: 200));
      final result = await _convoDbService.getAllConvo();
      cat.assignAll(result);
      final unique = result.map((e) => e.category).toSet().toList();
      uniqueCat.assignAll(unique);
      final cached = await _localStorage.getStringList(_translationCacheKey);
      if (cached != null && cached.length == result.length) {
        uniqueCat.assignAll(cached);
      } else {
        await _translateCat(unique);
      }
    } catch (e) {
      debugPrint('${AppExceptions().failToLoadDb}: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _translateCat(List<String> unique) async {
    translationLoading.value = true;
    try {
      final translations = await _translationService.translateList(
        uniqueCat,
        targetLanguage: 'ja',
      );
      catTranslations.assignAll(translations);
      await _localStorage.setStringList(_translationCacheKey, translations);
    } catch (e) {
      debugPrint('${AppExceptions().failToTranslate}: $e');
    } finally {
      translationLoading.value = false;
    }
  }

  List<String> getFilteredCat() {
    if (searchQuery.value.isEmpty) {
      return uniqueCat;
    }
    return uniqueCat
        .where(
          (cat) => cat.toLowerCase().contains(
            searchQuery.value.toLowerCase().trim(),
          ),
        )
        .toList();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
