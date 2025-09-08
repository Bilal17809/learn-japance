import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '/data/models/models.dart';
import '/core/services/services.dart';

class DictionaryController extends GetxController {
  final DictionaryDbService _dictionaryDbService;
  final _dictionaryData = <DictionaryModel>[].obs;
  var isLoading = true.obs;
  final RxString searchQuery = ''.obs;

  DictionaryController({required DictionaryDbService dictionaryDbService})
    : _dictionaryDbService = dictionaryDbService;

  @override
  void onInit() {
    super.onInit();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      isLoading.value = true;
      final result = await _dictionaryDbService.getDictionaryData();
      _dictionaryData.assignAll(result);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  List<DictionaryModel> getFilteredData() {
    if (searchQuery.value.isEmpty) {
      return _dictionaryData;
    }

    final query = searchQuery.value.toLowerCase();
    return _dictionaryData.where((item) {
      return item.english.toLowerCase().contains(query) ||
          item.japanese.toLowerCase().contains(query);
    }).toList();
  }
}
