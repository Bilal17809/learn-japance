import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '/core/local_storage/local_storage.dart';
import '/core/common/app_exceptions.dart';
import '/core/services/services.dart';
import '/data/models/models.dart';

class PhrasesTopicController extends GetxController {
  final PhrasesDbService _phrasesDbService;
  final TranslationService _translationService;
  final LocalStorage _localStorage;

  static const String _translationCacheKey = "topic_translations";
  var topics = <PhrasesTopicModel>[].obs;
  var topicTranslations = <String>[].obs;
  final int _pageSize = 5;
  int currentIndex = 0;
  final RxString searchQuery = ''.obs;
  var isLoading = true.obs;
  var translationsLoading = true.obs;

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
    try {
      await Future.delayed(const Duration(milliseconds: 200));
      final result = await _phrasesDbService.getAllTopics();
      topics.assignAll(result);
      topicTranslations.assignAll(List.filled(result.length, ''));
      final cached = await _localStorage.getStringList(_translationCacheKey);
      if (cached != null && cached.length == result.length) {
        topicTranslations.assignAll(cached);
      } else {
        await translateNextBatch();
      }
    } catch (e) {
      debugPrint('Error fetching topics: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> translateNextBatch() async {
    if (currentIndex >= topics.length) return;
    translationsLoading.value = true;
    try {
      final endIndex = (currentIndex + _pageSize).clamp(0, topics.length);
      final batch = topics.sublist(currentIndex, endIndex);

      final titles = batch.map((e) => e.title).toList();
      final translations = await _translationService.translateList(
        titles,
        targetLanguage: 'ja',
      );

      for (int i = 0; i < translations.length; i++) {
        topicTranslations[currentIndex + i] = translations[i];
      }

      currentIndex = endIndex;
      await _localStorage.setStringList(
        _translationCacheKey,
        topicTranslations.toList(),
      );
    } catch (e) {
      debugPrint('${AppExceptions().failToTranslate}: $e');
    } finally {
      translationsLoading.value = false;
    }
  }

  List<PhrasesTopicModel> getFilteredTopics() {
    if (searchQuery.value.isEmpty) {
      return topics;
    }
    return topics
        .where(
          (topic) => topic.title.toLowerCase().contains(
            searchQuery.value.toLowerCase().trim(),
          ),
        )
        .toList();
  }
}
