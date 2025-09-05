import 'package:get/get.dart';
import '/data/models/models.dart';
import '/core/services/services.dart';

class ConversationController extends GetxController {
  final TtsService _ttsService;

  ConversationController({required TtsService ttsService})
    : _ttsService = ttsService;

  final targetLanguage = Rx<LanguageModel>(
    LanguageModel(name: 'Japanese', code: 'ja', ttsCode: 'ja-JP'),
  );

  var showConversationMap = <int, bool>{}.obs;

  void onSpeak(String text) {
    _ttsService.speak(text, targetLanguage.value);
  }

  void toggleConvo(int index) {
    showConversationMap[index] = !(showConversationMap[index] ?? false);
  }

  bool isExpanded(int index) => showConversationMap[index] ?? false;
}
