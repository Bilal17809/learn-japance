import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '/core/helper/helper.dart';
import '/data/models/models.dart';
import '/core/services/services.dart';

class DictionaryController extends GetxController {
  final DictionaryDbService _dictionaryDbService;
  final TtsService _ttsService;
  final AiService _aiService;
  final _dictionaryData = <DictionaryModel>[].obs;
  final _expandedDictionaryData =
      <DictionaryModel>[].obs; // For comma-separated words
  final Rx<DictionaryModel?> selectedWord = Rx<DictionaryModel?>(null);
  final targetLanguage = Rx<LanguageModel>(
    LanguageModel(name: 'Japanese', code: 'ja', ttsCode: 'ja-JP'),
  );
  var wordDetails = Rxn<WordDetailsModel>();
  final RxString searchQuery = ''.obs;
  var isLoading = true.obs;
  var isAiLoading = false.obs;

  DictionaryController({
    required DictionaryDbService dictionaryDbService,
    required TtsService ttsService,
    required AiService aiService,
  }) : _dictionaryDbService = dictionaryDbService,
       _ttsService = ttsService,
       _aiService = aiService;

  @override
  void onInit() {
    super.onInit();
    _fetchData();
    ever(selectedWord, (word) {
      if (word != null) {
        getWordsDetails(word.english);
      }
    });
  }

  Future<void> _fetchData() async {
    try {
      isLoading.value = true;
      final result = await _dictionaryDbService.getDictionaryData();
      _dictionaryData.assignAll(result);
      _expandWords();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void _expandWords() {
    List<DictionaryModel> expandedList = [];
    for (var item in _dictionaryData) {
      final englishParts = item.english
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty);
      final japaneseParts = item.japanese
          .split('、')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty);
      final maxLength =
          englishParts.length > japaneseParts.length
              ? englishParts.length
              : japaneseParts.length;

      final englishList = englishParts.toList();
      final japaneseList = japaneseParts.toList();

      for (int i = 0; i < maxLength; i++) {
        final englishWord =
            i < englishList.length ? englishList[i] : englishList.last;
        final japaneseWord =
            i < japaneseList.length ? japaneseList[i] : japaneseList.last;

        expandedList.add(
          DictionaryModel(english: englishWord, japanese: japaneseWord),
        );
      }
    }

    _expandedDictionaryData.assignAll(expandedList);
  }

  List<DictionaryModel> getFilteredData() {
    if (searchQuery.value.isEmpty) {
      return _expandedDictionaryData;
    }
    final query = searchQuery.value.toLowerCase();
    return _expandedDictionaryData.where((item) {
      return item.english.toLowerCase().contains(query) ||
          item.japanese.toLowerCase().contains(query);
    }).toList();
  }

  void onSpeak(String text) {
    _ttsService.speak(text, targetLanguage.value);
  }

  Future<void> getWordsDetails(String word) async {
    if (word.trim().isEmpty) return;

    isAiLoading.value = true;
    wordDetails.value = null;

    try {
      final response = await _aiService.sendMessage([
        {"role": "system", "content": PromptHelper.dictionaryPrompt},
        {"role": "user", "content": word.trim()},
      ]);

      wordDetails.value = _parseAiResponse(response);
    } catch (e) {
      debugPrint('Error: $e');
    } finally {
      isAiLoading.value = false;
    }
  }

  WordDetailsModel _parseAiResponse(String response) {
    String definition = '',
        partsOfSpeech = '',
        pronunciation = '',
        synonyms = '',
        antonyms = '';
    List<String> exList = [];
    String? currentSection;

    for (var line in response.split('\n')) {
      if (line.startsWith('Definition:')) {
        definition = line.replaceFirst('Definition:', '').trim();
        currentSection = 'definition';
      } else if (line.startsWith('Part of Speech:')) {
        partsOfSpeech = line.replaceFirst('Part of Speech:', '').trim();
        currentSection = 'pos';
      } else if (line.startsWith('Pronunciation:')) {
        pronunciation = line.replaceFirst('Pronunciation:', '').trim();
        currentSection = 'pron';
      } else if (line.startsWith('Examples:')) {
        currentSection = 'examples';
      } else if (line.startsWith('Synonyms:')) {
        synonyms = line.replaceFirst('Synonyms:', '').trim();
        currentSection = 'syn';
      } else if (line.startsWith('Antonyms:')) {
        antonyms = line.replaceFirst('Antonyms:', '').trim();
        currentSection = 'ant';
      } else {
        if (currentSection == 'examples' && line.trim().isNotEmpty) {
          exList.add(line.trim().replaceFirst('- ', ''));
        } else if (currentSection == 'syn') {
          synonyms += ' ${line.trim()}';
        } else if (currentSection == 'ant') {
          antonyms += ' ${line.trim()}';
        }
      }
    }

    return WordDetailsModel(
      definition: definition,
      partOfSpeech: partsOfSpeech,
      pronunciation: pronunciation,
      examples: exList.join('\n'),
      synonyms: synonyms.trim(),
      antonyms: antonyms.trim(),
    );
  }

  @override
  void onClose() {
    _ttsService.stop();
    super.onClose();
  }
}
