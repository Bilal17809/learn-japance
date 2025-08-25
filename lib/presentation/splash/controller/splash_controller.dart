import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '/data/models/models.dart';
import '/core/services/services.dart';

class SplashController extends GetxController {
  final GrammarDbService _dataService;
  final PhrasesDbService _phrasesDbService;

  SplashController({
    required GrammarDbService dataService,
    required PhrasesDbService phrasesDbService,
  }) : _dataService = dataService,
       _phrasesDbService = phrasesDbService;

  final isLoading = true.obs;
  final isDataLoaded = false.obs;
  var showButton = false.obs;

  List<GrammarModel>? grammarData;
  List<LanguageModel>? lngData;

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
      lngData = await _lngService.loadLanguages();
      isDataLoaded.value = true;
      debugPrint("///////////////Phrases DB initialized successfully");
      debugPrint("Grammar dataset loaded: ${grammarData?.length} items");
      debugPrint("Lng dataset loaded: ${lngData?.length} items");
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
      showButton.value = true;
    }
  }
}
