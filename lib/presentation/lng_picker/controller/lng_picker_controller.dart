import 'package:get/get.dart';
import '/data/models/models.dart';

class LngPickerController extends GetxController {
  final List<LanguageModel> allLanguages;
  final RxList<LanguageModel> filteredLanguages = <LanguageModel>[].obs;
  final RxString query = ''.obs;

  LngPickerController({required this.allLanguages});

  @override
  void onInit() {
    super.onInit();
    filteredLanguages.assignAll(allLanguages);
  }

  void search(String value) {
    query.value = value;
    if (value.isEmpty) {
      filteredLanguages.assignAll(allLanguages);
    } else {
      final lower = value.toLowerCase();
      filteredLanguages.assignAll(
        allLanguages.where(
          (lng) =>
              lng.name.toLowerCase().contains(lower) ||
              lng.code.toLowerCase().contains(lower) ||
              lng.flagEmoji.contains(value),
        ),
      );
    }
  }
}
