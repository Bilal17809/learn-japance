import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '/data/models/models.dart';
import '/core/services/services.dart';

class DictionaryController extends GetxController {
  final DictionaryDbService _dictionaryDbService;

  DictionaryController({required DictionaryDbService dictionaryDbService})
    : _dictionaryDbService = dictionaryDbService;

  var dictionaryData = <DictionaryModel>[].obs;
  var isLoading = true.obs;
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      isLoading.value = true;
      final result = await _dictionaryDbService.getDictionaryData();
      dictionaryData.assignAll(result);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  List<DictionaryModel> getFilteredData() {
    if (searchQuery.value.isEmpty) {
      return dictionaryData;
    }

    final query = searchQuery.value.toLowerCase();
    return dictionaryData.where((item) {
      return item.english.toLowerCase().contains(query) ||
          item.japanese.toLowerCase().contains(query);
    }).toList();
  }
}
