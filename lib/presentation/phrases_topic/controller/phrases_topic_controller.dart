import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '/core/local_storage/local_storage.dart';
import '/core/common/app_exceptions.dart';
import '/core/services/services.dart';
import '/data/models/models.dart';

class PhrasesTopicController extends GetxController {
  final DbService _phrasesDbService;
  final TranslationService _translationService;
  final LocalStorage _localStorage;

  PhrasesTopicController({
    required DbService phrasesDbService,
    required TranslationService translationService,
    required LocalStorage localStorage,
  }) : _phrasesDbService = phrasesDbService,
       _translationService = translationService,
       _localStorage = localStorage;

  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;
  var topics = <PhrasesTopicModel>[].obs;
  var topicTranslations = <String>[].obs;
  var isLoading = true.obs;
  static const String _translationCacheKey = "topic_translations";
  var translationsLoading = true.obs;
  var error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _fetchTopics();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  Future<void> _fetchTopics() async {
    isLoading.value = true;
    try {
      await Future.delayed(const Duration(milliseconds: 350));
      error.value = '';
      final result = await _phrasesDbService.getAllTopics();
      topics.assignAll(result);
      final cached = await _localStorage.getStringList(_translationCacheKey);
      if (cached != null && cached.length == result.length) {
        topicTranslations.assignAll(cached);
      } else {
        await translateTopics(result);
      }
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> translateTopics(List<PhrasesTopicModel> data) async {
    translationsLoading.value = true;
    try {
      final titles = data.map((e) => e.title).toList();
      final translations = await _translationService.translateList(
        titles,
        targetLanguage: 'ja',
      );

      topicTranslations.assignAll(translations);
      await _localStorage.setStringList(_translationCacheKey, translations);
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
