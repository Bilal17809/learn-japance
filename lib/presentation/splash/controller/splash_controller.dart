import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '/data/models/models.dart';
import '/core/services/services.dart';

class SplashController extends GetxController {
  final GrammarDbService _dataService = Get.find<GrammarDbService>();
  final PhrasesDbService _phrasesDbService = Get.find<PhrasesDbService>();

  final isLoading = true.obs;
  final isDataLoaded = false.obs;
  var showButton = false.obs;

  List<GrammarModel>? grammarData;

  @override
  void onInit() {
    super.onInit();
    _initApp();
  }

  Future<void> _initApp() async {
    try {
      isLoading.value = true;
      isDataLoaded.value = false;
      grammarData = await _dataService.loadGrammarData();
      await _phrasesDbService.database;
      isDataLoaded.value = true;
      debugPrint("///////////////Phrases DB initialized successfully");
      debugPrint("Grammar dataset loaded: ${grammarData?.length} items");
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
      showButton.value = true;
    }
  }
}
