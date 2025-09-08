import 'package:get/get.dart';
import '/data/models/models.dart';
import '/core/services/services.dart';

class ConversationController extends GetxController {
  final TtsService _ttsService;
  final _targetLanguage = Rx<LanguageModel>(
    LanguageModel(name: 'Japanese', code: 'ja', ttsCode: 'ja-JP'),
  );

  ConversationController({required TtsService ttsService})
    : _ttsService = ttsService;

  var showConversationMap = <int, bool>{}.obs;

  void onSpeak(String text) {
    _ttsService.speak(text, _targetLanguage.value);
  }

  void toggleConversation(int index) {
    showConversationMap[index] = !(showConversationMap[index] ?? false);
  }

  bool isExpanded(int index) => showConversationMap[index] ?? false;
}
