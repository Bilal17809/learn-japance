import 'package:get/get.dart';
import '/data/models/models.dart';
import '/core/services/services.dart';
import '/presentation/splash/controller/splash_controller.dart';

class PhrasesController extends GetxController {
  final SplashController splashController = Get.find<SplashController>();
  final TranslationService translationService = TranslationService();

  var categoryTranslations = <String, String>{}.obs;
  var translatingStates = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    translateAllCategories();
  }

  void translateAllCategories() {
    if (splashController.japaneseData == null) return;

    final categories = getUniqueCategories(splashController.japaneseData!);
    for (final category in categories) {
      translateCategory(category);
    }
  }

  Future<void> translateCategory(String category) async {
    if (categoryTranslations.containsKey(category)) return;

    translatingStates[category] = true;

    try {
      final translation = await translationService.translateText(category);
      categoryTranslations[category] = translation;
    } catch (e) {
      categoryTranslations[category] = category; // fallback
    } finally {
      translatingStates[category] = false;
    }
  }

  List<String> getUniqueCategories(List<GrammarModel> data) {
    final categories = data.map((e) => e.category).toSet().toList();
    categories.sort();
    return categories;
  }

  int getCategoryItemCount(List<GrammarModel> data, String category) {
    return data.where((item) => item.category == category).length;
  }
}
