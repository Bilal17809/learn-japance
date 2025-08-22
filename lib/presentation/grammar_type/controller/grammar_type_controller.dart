import 'package:get/get.dart';
import '/data/models/models.dart';
import '/core/services/services.dart';
import '/presentation/splash/controller/splash_controller.dart';

class GrammarTypeController extends GetxController {
  final SplashController splashController = Get.find<SplashController>();
  final TranslationService translationService = TranslationService();

  var categoryTranslations = <String, String>{}.obs;
  var translationsLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    translateAllCategories();
  }

  void translateAllCategories() async {
    if (splashController.grammarData == null) return;
    final categories = getUniqueCategories(splashController.grammarData!);
    try {
      final translations = await translationService.translateList(categories);
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
