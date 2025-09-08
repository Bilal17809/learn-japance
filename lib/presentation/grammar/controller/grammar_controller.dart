import 'package:get/get.dart';
import '/core/common/app_exceptions.dart';
import '/data/models/models.dart';
import '/core/services/services.dart';

class GrammarController extends GetxController {
  final GrammarDbService _grammarDbService;
  final TranslationService _translationService;
  final RxList<GrammarModel> _allData = <GrammarModel>[].obs;
  final RxMap<String, String> translationCache = <String, String>{}.obs;
  final RxMap<String, bool> translatingStates = <String, bool>{}.obs;
  var isLoading = true.obs;
  final RxString searchQuery = ''.obs;

  GrammarController({
    required GrammarDbService grammarDbService,
    required TranslationService translationService,
  }) : _grammarDbService = grammarDbService,
       _translationService = translationService;

  @override
  void onInit() {
    super.onInit();
    _fetchData();
  }

  Future<void> _fetchData() async {
    isLoading.value = true;
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      final data = await _grammarDbService.loadGrammarData();
      _allData.assignAll(data);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> translateText(String key, String text) async {
    if (translationCache.containsKey(key)) return;
    translatingStates[key] = true;
    try {
      final translation = await _translationService.translateText(text);
      translationCache[key] = translation;
    } catch (e) {
      translationCache[key] = "${AppExceptions().failToTranslate}: $e";
    } finally {
      translatingStates[key] = false;
    }
  }

  Future<void> translateAll(GrammarModel item) async {
    final textsToTranslate = [
      item.category,
      item.description,
      ...item.examples,
    ];
    final translations = await _translationService.translateList(
      textsToTranslate,
    );
    await translateText("${item.id}_category", translations[0]);
    await translateText("${item.id}_description", translations[1]);

    for (int i = 0; i < item.examples.length; i++) {
      await translateText("${item.id}_example_$i", translations[i + 2]);
    }
  }

  List<GrammarModel> getFilteredData(String category) {
    final filtered =
        _allData.where((item) => item.category == category).toList();

    if (searchQuery.value.isNotEmpty) {
      return filtered
          .where(
            (item) => item.title.toLowerCase().contains(
              searchQuery.value.toLowerCase().trim(),
            ),
          )
          .toList();
    }

    return filtered;
  }
}
