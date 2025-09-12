import 'package:get/get.dart';
import '/core/services/services.dart';
import '/data/models/models.dart';

class PracticeController extends GetxController {
  final TtsService _ttsService;
  final SpeechService _speechService;
  var practiceData = <LearnModel>[].obs;
  var category = ''.obs;
  var japCategory = ''.obs;
  var startIndex = 0.obs;
  var currentWordIndex = 0.obs;
  var currentPage = 0.obs;
  var selectedAnswerPage1 = ''.obs;
  var selectedAnswerPage2 = ''.obs;
  var showResultPage1 = false.obs;
  var showResultPage2 = false.obs;
  var showResultPage4 = false.obs;
  var userTextInput = ''.obs;
  var isCorrectPage4 = false.obs;
  var optionsPage1 = <String>[].obs;
  var optionsPage2 = <String>[].obs;
  final targetLanguage = Rx<LanguageModel>(
    LanguageModel(name: 'Japanese', code: 'ja', ttsCode: 'JA'),
  );

  PracticeController({
    required TtsService ttsService,
    required SpeechService speechService,
  }) : _ttsService = ttsService,
       _speechService = speechService;

  void setArguments(
    List<LearnModel> data,
    String categoryName,
    String japCategoryName,
    int start,
  ) {
    practiceData.assignAll(data);
    category.value = categoryName;
    japCategory.value = japCategoryName;
    startIndex.value = start;
    currentWordIndex.value = start;
    resetAllPageStates();
    generateOptionsForBothPages();
  }

  void resetAllPageStates() {
    selectedAnswerPage1.value = '';
    selectedAnswerPage2.value = '';
    showResultPage1.value = false;
    showResultPage2.value = false;
    showResultPage4.value = false;
    userTextInput.value = '';
    isCorrectPage4.value = false;
  }

  void generateOptionsForBothPages() {
    final options = _generateOptionsForCurrentWord();
    optionsPage1.assignAll(List.from(options)..shuffle());
    optionsPage2.assignAll(List.from(options)..shuffle());
  }

  List<String> _generateOptionsForCurrentWord() {
    if (currentWordIndex.value < practiceData.length) {
      final currentWord = practiceData[currentWordIndex.value];
      final correctAnswer = currentWord.english;

      final wrongAnswers =
          practiceData
              .where((item) => item.english != correctAnswer)
              .take(3)
              .map((item) => item.english)
              .toList();

      while (wrongAnswers.length < 3 &&
          wrongAnswers.length < practiceData.length - 1) {
        final remaining =
            practiceData
                .where(
                  (item) =>
                      item.english != correctAnswer &&
                      !wrongAnswers.contains(item.english),
                )
                .toList();
        if (remaining.isNotEmpty) {
          wrongAnswers.add(remaining.first.english);
        } else {
          break;
        }
      }

      return [correctAnswer, ...wrongAnswers];
    }
    return [];
  }

  void selectAnswerPage1(String answer) {
    selectedAnswerPage1.value = answer;
    showResultPage1.value = true;
  }

  void selectAnswerPage2(String answer) {
    selectedAnswerPage2.value = answer;
    showResultPage2.value = true;
  }

  void checkWritingAnswer() {
    if (userTextInput.value.isNotEmpty) {
      isCorrectPage4.value = isAnswerCorrect(userTextInput.value);
      showResultPage4.value = true;
    }
  }

  void updateTextInput(String value) {
    userTextInput.value = value;
    if (showResultPage4.value) {
      showResultPage4.value = false;
    }
  }

  bool isAnswerCorrect(String userAnswer) {
    if (currentWordIndex.value < practiceData.length) {
      final correctAnswer = practiceData[currentWordIndex.value].english;
      return userAnswer.toLowerCase().trim() ==
          correctAnswer.toLowerCase().trim();
    }
    return false;
  }

  LearnModel? get currentWord {
    if (practiceData.isEmpty) return null;
    if (currentWordIndex.value < practiceData.length) {
      return practiceData[currentWordIndex.value];
    }
    return practiceData.first;
  }

  void onSpeak(String text) {
    _ttsService.speak(text, targetLanguage.value);
  }

  @override
  void onClose() {
    _ttsService.onClose();
    super.onClose();
  }
}
