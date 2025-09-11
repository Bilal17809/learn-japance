import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '/core/common/app_exceptions.dart';
import '/data/models/models.dart';
import '/core/services/services.dart';

class PracticeController extends GetxController {
  final LearnDbService _learnDbService;
  final TtsService _ttsService;
  var data = <LearnModel>[].obs;
  final targetLanguage = Rx<LanguageModel>(
    LanguageModel(name: 'Japanese', code: 'ja', ttsCode: 'ja-JP'),
  );
  final _topicId = 0.obs;
  var currentPage = 0.obs;
  var isLoading = true.obs;
  PracticeController({
    required LearnDbService learnDbService,
    required TtsService ttsService,
  }) : _learnDbService = learnDbService,
       _ttsService = ttsService;

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

  void onSpeak(String text) {
    _ttsService.speak(text, targetLanguage.value);
  }

  @override
  void onClose() {
    _ttsService.stop();
    super.onClose();
  }
}
