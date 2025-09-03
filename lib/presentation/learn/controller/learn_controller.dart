import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:learn_japan/core/common/app_exceptions.dart';
import '/data/models/models.dart';
import '/core/services/services.dart';

class LearnController extends GetxController {
  final LearnDbService _learnDbService;
  final TtsService _ttsService;

  LearnController({
    required LearnDbService learnDbService,
    required TtsService ttsService,
  }) : _learnDbService = learnDbService,
       _ttsService = ttsService;

  var isLoading = true.obs;
  var data = <LearnModel>[].obs;
  var topicId = 0.obs;
  final targetLanguage = Rx<LanguageModel>(
    LanguageModel(name: 'Japanese', code: 'ja', ttsCode: 'ja-JP'),
  );

  void setTopic(int id) {
    topicId.value = id;
    _fetchData();
  }

  Future<void> _fetchData() async {
    isLoading.value = true;
    try {
      await Future.delayed(const Duration(milliseconds: 200));
      final result = await _learnDbService.getCatByTopic(topicId.value + 1);
      data.assignAll(result);
    } catch (e) {
      debugPrint('${AppExceptions().failToLoadDb}: $e');
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
