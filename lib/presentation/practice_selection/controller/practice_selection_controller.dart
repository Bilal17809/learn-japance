import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '/core/common/app_exceptions.dart';
import '/data/models/models.dart';
import '/core/services/services.dart';

class PracticeSelectionController extends GetxController {
  final LearnDbService _learnDbService;
  var data = <LearnModel>[].obs;
  final _topicId = 0.obs;
  var currentPage = 0.obs;
  var isLoading = true.obs;
  var isCompleted = false.obs;
  PracticeSelectionController({required LearnDbService learnDbService})
    : _learnDbService = learnDbService;

  @override
  void onInit() {
    _fetchData();
    super.onInit();
  }

  void setTopic(int id) {
    _topicId.value = id;
    _fetchData();
  }

  Future<void> _fetchData() async {
    isLoading.value = true;
    try {
      await Future.delayed(const Duration(milliseconds: 200));
      final result = await _learnDbService.getCategoryByTopic(
        _topicId.value + 1,
      );
      data.assignAll(result);
    } catch (e) {
      debugPrint('${AppExceptions().failToFetchData}: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
