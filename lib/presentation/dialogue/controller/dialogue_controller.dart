import 'package:get/get.dart';
import '/core/local_storage/local_storage.dart';
import '/presentation/home/controller/home_controller.dart';
import '/data/models/models.dart';
import '/core/services/services.dart';

class DialogueController extends GetxController {
  final LocalStorage _localStorage;
  final TtsService _ttsService;
  final _targetLanguage = Rx<LanguageModel>(
    LanguageModel(name: 'Japanese', code: 'ja', ttsCode: 'ja-JP'),
  );
  var showConversationMap = <int, bool>{}.obs;
  var learnedDialogues = <String, bool>{}.obs;
  var index = 0.obs;

  DialogueController({
    required LocalStorage localStorage,
    required TtsService ttsService,
  }) : _localStorage = localStorage,
       _ttsService = ttsService;

  Future<void> learnDialogue(String category, int index) async {
    final key = "${category}_$index";
    learnedDialogues[key] = true;
    await _localStorage.setBool(key, true);
    await Get.find<HomeController>().increaseProgress(isDialogue: true);
  }

  Future<void> loadLearnedDialogues(String category, int count) async {
    for (var i = 0; i < count; i++) {
      final key = "${category}_$i";
      final isLearned = await _localStorage.getBool(key) ?? false;
      learnedDialogues[key] = isLearned;
    }
  }

  void onSpeak(String text) {
    _ttsService.speak(text, _targetLanguage.value);
  }

  void stopTts() {
    _ttsService.stop();
  }

  @override
  void onClose() {
    _ttsService.onClose();
    super.onClose();
  }
}
