import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:learn_japan/core/local_storage/local_storage.dart';
import '/core/services/phrases_db_service.dart';
import '/core/services/translation_service.dart';
import '/data/models/models.dart';

class PhrasesTopicController extends GetxController {
  final PhrasesDbService dbService = Get.find<PhrasesDbService>();
  final TranslationService translationService = TranslationService();
  final LocalStorage localStorage = LocalStorage();
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
    fetchTopics();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  Future<void> fetchTopics() async {
    isLoading.value = true;
    try {
      await Future.delayed(const Duration(milliseconds: 350));
      error.value = '';
      final result = await dbService.getAllTopics();
      topics.assignAll(result);
      final cached = await localStorage.getStringList(_translationCacheKey);
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
      final translations = await translationService.translateList(
        titles,
        targetLanguage: 'ja',
      );

      topicTranslations.assignAll(translations);
      await localStorage.setStringList(_translationCacheKey, translations);
    } catch (e) {
      debugPrint('Translation error: $e');
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
