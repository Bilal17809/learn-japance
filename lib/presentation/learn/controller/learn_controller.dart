import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '/core/common/app_exceptions.dart';
import '/data/models/models.dart';
import '/core/services/services.dart';

class LearnController extends GetxController {
  final LearnDbService _learnDbService;
  final TtsService _ttsService;
  final targetLanguage = Rx<LanguageModel>(
    LanguageModel(name: 'Japanese', code: 'ja', ttsCode: 'ja-JP'),
  );
  var data = <LearnModel>[].obs;
  final _topicId = 0.obs;
  var isLoading = true.obs;

  LearnController({
    required LearnDbService learnDbService,
    required TtsService ttsService,
  }) : _learnDbService = learnDbService,
       _ttsService = ttsService;

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
