import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '/core/common/app_exceptions.dart';
import '/data/models/learn_topic_model.dart';
import '/core/services/services.dart';

class LearnCatController extends GetxController {
  final LearnDbService _learnDbService;

  LearnCatController({required LearnDbService learnDbService})
    : _learnDbService = learnDbService;

  var isLoading = true.obs;
  var topics = <LearnTopicModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _fetchTopics();
  }

  Future<void> _fetchTopics() async {
    isLoading.value = true;
    try {
      await Future.delayed(const Duration(milliseconds: 200));
      final result = await _learnDbService.getAllTopics();
      topics.assignAll(result);
    } catch (e) {
      debugPrint('${AppExceptions().failToTranslate}: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
