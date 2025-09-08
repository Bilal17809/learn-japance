import 'package:get/get.dart';
import '/data/models/models.dart';
import '/core/services/services.dart';

class GrammarTypeController extends GetxController {
  final TranslationService _translationService;
  final GrammarDbService _grammarDbService;
  var categoryTranslations = <String, String>{}.obs;
  List<GrammarModel>? grammarData;
  var translationsLoading = true.obs;

  GrammarTypeController({
    required TranslationService translationService,
    required GrammarDbService grammarDbService,
  }) : _grammarDbService = grammarDbService,
       _translationService = translationService;

  @override
  void onInit() {
    super.onInit();
    translateAllCategories();
  }

  Future<void> translateAllCategories() async {
    grammarData = await _grammarDbService.loadGrammarData();

    final categories = getUniqueCategories(grammarData!);
    try {
      final translations = await _translationService.translateList(categories);
      for (int i = 0; i < categories.length; i++) {
        categoryTranslations[categories[i]] = translations[i];
      }
    } catch (e) {
      for (final category in categories) {
        categoryTranslations[category] = category;
      }
    } finally {
      translationsLoading.value = false;
    }
  }

  List<String> getUniqueCategories(List<GrammarModel> data) {
    final categories = data.map((e) => e.category).toSet().toList();
    categories.sort();
    return categories;
  }
}
