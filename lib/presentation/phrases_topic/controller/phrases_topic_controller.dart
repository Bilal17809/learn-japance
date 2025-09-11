import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '/core/mixins/connectivity_mixin.dart';
import '/core/local_storage/local_storage.dart';
import '/core/common/app_exceptions.dart';
import '/core/services/services.dart';
import '/data/models/models.dart';

class PhrasesTopicController extends GetxController with ConnectivityMixin {
  final PhrasesDbService _phrasesDbService;
  final TranslationService _translationService;
  final LocalStorage _localStorage;
  var topics = <PhrasesTopicModel>[];
  var visibleTopics = <PhrasesTopicModel>[].obs;
  var topicTranslations = <String>[].obs;
  final int _pageSize = 8;
  int currentIndex = 0;
  final RxString searchQuery = ''.obs;
  var isLoading = true.obs;
  var translationsLoading = false.obs;
  PhrasesTopicController({
    required PhrasesDbService phrasesDbService,
    required TranslationService translationService,
    required LocalStorage localStorage,
  }) : _phrasesDbService = phrasesDbService,
       _translationService = translationService,
       _localStorage = localStorage;

  @override
  void onInit() {
    super.onInit();
    _fetchTopics();
  }

  Future<void> _fetchTopics() async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 100));
    try {
      final result = await _phrasesDbService.getAllTopics();
      topics = result;
      topicTranslations.assignAll(List.filled(result.length, ''));
      final cached = await _localStorage.getStringList("topic_translations");
      final savedProgress =
          await _localStorage.getInt("topic_translation_progress") ?? 0;
      if (cached != null && cached.isNotEmpty) {
        for (int i = 0; i < cached.length && i < topics.length; i++) {
          topicTranslations[i] = cached[i];
        }
        visibleTopics.assignAll(topics.sublist(0, savedProgress));
        currentIndex = savedProgress;
      }
      if (currentIndex < topics.length) {
        await translateBatch();
      }
    } catch (e) {
      debugPrint('${AppExceptions().failToFetchData}: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> translateBatch() async {
    if (currentIndex >= topics.length) return;
    translationsLoading.value = true;
    await initWithConnectivityCheck(
      context: Get.context!,
      onConnected: () async {
        final endIndex = (currentIndex + _pageSize).clamp(0, topics.length);
        final batch = topics.sublist(currentIndex, endIndex);
        final titles = batch.map((e) => e.title).toList();
        try {
          final translations = await _translationService.translateList(
            titles,
            targetLanguage: 'ja',
          );
          for (int i = 0; i < translations.length; i++) {
            topicTranslations[currentIndex + i] = translations[i];
          }
          visibleTopics.addAll(batch);
          currentIndex = endIndex;
          await _localStorage.setStringList(
            "topic_translations",
            topicTranslations.toList(),
          );
          await _localStorage.setInt(
            "topic_translation_progress",
            currentIndex,
          );
        } catch (e) {
          debugPrint("${AppExceptions().failToTranslate}: $e");
        } finally {
          translationsLoading.value = false;
        }
      },
    );
  }

  List<PhrasesTopicModel> getFilteredTopics() {
    if (searchQuery.value.isEmpty) {
      return visibleTopics;
    }
    return visibleTopics
        .where(
          (topic) => topic.title.toLowerCase().contains(
            searchQuery.value.toLowerCase().trim(),
          ),
        )
        .toList();
  }
}
