import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '/core/common/app_exceptions.dart';
import '/data/models/models.dart';
import '/core/services/services.dart';

class PracticeCategoryController extends GetxController {
  final LearnDbService _learnDbService;
  var isLoading = true.obs;
  var topics = <LearnTopicModel>[].obs;
  PracticeCategoryController({required LearnDbService learnDbService})
    : _learnDbService = learnDbService;

  @override
  void onInit() {
    _fetchCategories();
    super.onInit();
  }

  Future<void> _fetchCategories() async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 200));
    final result = await _learnDbService.getAllTopics();
    topics.assignAll(result);
    try {} catch (e) {
      debugPrint('${AppExceptions().failToFetchData}: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
