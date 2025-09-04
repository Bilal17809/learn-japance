import 'package:get/get.dart';
import '/data/models/models.dart';
import '/core/services/services.dart';

class ConvoController extends GetxController {
  final TtsService _ttsService;

  ConvoController({required TtsService ttsService}) : _ttsService = ttsService;

  final targetLanguage = Rx<LanguageModel>(
    LanguageModel(name: 'Japanese', code: 'ja', ttsCode: 'ja-JP'),
  );

  var showConvoMap = <int, bool>{}.obs;

  void onSpeak(String text) {
    _ttsService.speak(text, targetLanguage.value);
  }

  void toggleConvo(int index) {
    showConvoMap[index] = !(showConvoMap[index] ?? false);
  }

  bool isExpanded(int index) => showConvoMap[index] ?? false;
}
