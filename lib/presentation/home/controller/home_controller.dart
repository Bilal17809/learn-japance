import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '/core/local_storage/local_storage.dart';
import '/core/services/services.dart';
import '/data/models/models.dart';
import '/presentation/jws/controller/jws_controller.dart';

class HomeController extends GetxController {
  final JwsController _jwsController;
  final LocalStorage _localStorage;
  final TtsService _ttsService;
  final targetLanguage = Rx<LanguageModel>(
    LanguageModel(name: 'Japanese', code: 'ja', ttsCode: 'ja-JP'),
  );
  var currentWord = 'あ'.obs;
  var currentRomaji = 'a'.obs;
  var currentScriptType = 'hiragana'.obs;
  var isDrawerOpen = false.obs;
  var dailyProgress = 0.obs;
  var overallProgress = 0.obs;
  var phrasesLearnedToday = 0.obs;
  var dialoguesLearnedToday = 0.obs;
  var practiceToday = 0.obs;

  HomeController({
    required JwsController jwsController,
    required TtsService ttsService,
    required LocalStorage localStorage,
  }) : _jwsController = jwsController,
       _localStorage = localStorage,
       _ttsService = ttsService;

  @override
  void onInit() {
    super.onInit();
    _loadDailyWord();
    _loadDailyProgress();
  }

  Future<void> _loadDailyWord() async {
    while (_jwsController.isLoading.value) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
    final allItems = [
      ..._getItems('hiragana', _jwsController),
      ..._getItems('katakana', _jwsController),
    ];
    if (allItems.isEmpty) return;
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final lastDate = await _localStorage.getString('last_date');
    int storedIndex =
        int.tryParse(await _localStorage.getString('character_index') ?? '0') ??
        0;
    if (lastDate != null && today != lastDate) {
      storedIndex++;
      await _localStorage.setString('character_index', storedIndex.toString());
      await _localStorage.setString('last_date', today);
    } else if (lastDate == null) {
      await _localStorage.setString('last_date', today);
    }

    final nextIndex = storedIndex % allItems.length;
    final item = allItems[nextIndex];
    if (item is HiraganaItem) {
      currentScriptType.value = 'hiragana';
      currentWord.value = item.hiragana;
      currentRomaji.value = item.romaji;
    } else if (item is KatakanaItem) {
      currentScriptType.value = 'katakana';
      currentWord.value = item.katakana;
      currentRomaji.value = item.romaji;
    }
  }

  Future<void> _loadDailyProgress() async {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final lastProgressDate = await _localStorage.getString(
      'last_progress_date',
    );
    if (lastProgressDate != today) {
      phrasesLearnedToday.value = 0;
      dialoguesLearnedToday.value = 0;
      dailyProgress.value = 0;
      practiceToday.value = 0;
      await _localStorage.setString('last_progress_date', today);
      await _localStorage.setInt('phrases_learned_today', 0);
      await _localStorage.setInt('dialogues_learned_today', 0);
      await _localStorage.setInt('practice_today', 0);
      await _localStorage.setInt('daily_progress', 0);
    } else {
      phrasesLearnedToday.value =
          await _localStorage.getInt('phrases_learned_today') ?? 0;
      dialoguesLearnedToday.value =
          await _localStorage.getInt('dialogues_learned_today') ?? 0;
      practiceToday.value = await _localStorage.getInt('practice_today') ?? 0;
      dailyProgress.value = await _localStorage.getInt('daily_progress') ?? 0;
    }
    overallProgress.value = await _localStorage.getInt('overall_progress') ?? 0;
  }

  Future<void> increaseProgress({
    bool isDialogue = false,
    bool isPractice = false,
  }) async {
    dailyProgress.value++;
    overallProgress.value++;
    if (isDialogue) {
      dialoguesLearnedToday.value++;
      await _localStorage.setInt(
        'dialogues_learned_today',
        dialoguesLearnedToday.value,
      );
    } else if (isPractice) {
      practiceToday.value++;
      await _localStorage.setInt('practice_today', practiceToday.value);
    } else {
      phrasesLearnedToday.value++;
      await _localStorage.setInt(
        'phrases_learned_today',
        phrasesLearnedToday.value,
      );
    }
    await _localStorage.setInt('daily_progress', dailyProgress.value);
    await _localStorage.setInt('overall_progress', overallProgress.value);
  }

  void onSpeak(String text) {
    _ttsService.speak(text, targetLanguage.value);
  }

  List<dynamic> _getItems(String type, JwsController jwsController) {
    if (type == 'hiragana') {
      final h = jwsController.hiraganaData.value?.hiragana;
      return h != null ? [...h.gojuon, ...h.dakuten, ...h.yoon] : [];
    } else {
      final k = jwsController.katakanaData.value?.katakana;
      return k != null
          ? [...k.gojuon, ...k.dakuten, ...k.yoon, ...k.loanwords]
          : [];
    }
  }

  String get currentScriptDisplayName =>
      currentScriptType.value == 'hiragana' ? 'Hiragana' : 'Katakana';

  @override
  void onClose() {
    _ttsService.stop();
    super.onClose();
  }
}
