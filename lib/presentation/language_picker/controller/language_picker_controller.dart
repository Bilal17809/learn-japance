import 'package:get/get.dart';
import '/data/models/models.dart';

class LanguagePickerController extends GetxController {
  final List<LanguageModel> _allLanguages;
  final RxList<LanguageModel> filteredLanguages = <LanguageModel>[].obs;
  final RxString _query = ''.obs;

  LanguagePickerController({required List<LanguageModel> allLanguages})
    : _allLanguages = allLanguages;

  @override
  void onInit() {
    super.onInit();
    filteredLanguages.assignAll(_allLanguages);
  }

  void search(String value) {
    _query.value = value;
    if (value.isEmpty) {
      filteredLanguages.assignAll(_allLanguages);
    } else {
      final lower = value.toLowerCase();
      filteredLanguages.assignAll(
        _allLanguages.where(
          (language) =>
              language.name.toLowerCase().contains(lower) ||
              language.code.toLowerCase().contains(lower) ||
              language.flagEmoji.contains(value),
        ),
      );
    }
  }
}
