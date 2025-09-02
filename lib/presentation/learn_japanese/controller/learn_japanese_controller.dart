import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '/core/common/app_exceptions.dart';
import '/data/models/learn_topic_model.dart';
import '/core/services/services.dart';

class LearnJapaneseController extends GetxController {
  final LearnDbService _learnDbService;

  LearnJapaneseController({required LearnDbService learnDbService})
    : _learnDbService = learnDbService;

  final isLoading = true.obs;
  var topics = <LearnTopicModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _fetchTopics();
  }

  Future<void> _fetchTopics() async {
    isLoading.value = true;
    try {
      final result = await _learnDbService.getAllTopics();
      topics.assignAll(result);
    } catch (e) {
      debugPrint('${AppExceptions().failToTranslate}: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
