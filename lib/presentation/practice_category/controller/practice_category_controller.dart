import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '/core/local_storage/local_storage.dart';
import '/core/common/app_exceptions.dart';
import '/data/models/models.dart';
import '/core/services/services.dart';

class PracticeCategoryController extends GetxController {
  final LocalStorage _localStorage;
  final LearnDbService _learnDbService;

  var isLoading = true.obs;
  var topics = <LearnTopicModel>[].obs;
  var categoryProgress = <String, int>{}.obs;

  PracticeCategoryController({
    required LocalStorage localStorage,
    required LearnDbService learnDbService,
  }) : _localStorage = localStorage,
       _learnDbService = learnDbService;

  @override
  void onInit() {
    super.onInit();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    isLoading.value = true;
    try {
      final result = await _learnDbService.getAllTopics();
      topics.assignAll(result);
      for (final topic in result) {
        final key = 'progress_${topic.english}';
        final value = await _localStorage.getInt(key) ?? 0;
        categoryProgress[topic.english] = value;
      }
    } on Exception catch (e) {
      debugPrint('${AppExceptions().failToFetchData}: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> increasePracticeProgress(String category) async {
    final key = 'progress_$category';
    final current = categoryProgress[category] ?? 0;
    categoryProgress[category] = current + 1;
    await _localStorage.setInt(key, categoryProgress[category]!);
  }
}
