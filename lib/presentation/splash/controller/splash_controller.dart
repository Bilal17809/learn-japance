import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '/data/models/models.dart';
import '/core/services/services.dart';

class SplashController extends GetxController {
  final GrammarService _dataService = Get.find<GrammarService>();

  final isLoading = true.obs;
  final isDataLoaded = false.obs;
  var showButton = false.obs;

  List<GrammarModel>? japaneseData;

  @override
  void onInit() {
    super.onInit();
    _initApp();
  }

  Future<void> _initApp() async {
    try {
      isLoading.value = true;
      isDataLoaded.value = false;
      japaneseData = await _dataService.loadJapaneseDataset();
      isDataLoaded.value = true;
      debugPrint("Japanese dataset loaded: ${japaneseData?.length} items");
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
      showButton.value = true;
    }
  }
}
