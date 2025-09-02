import 'package:get/get.dart';
import '/core/utils/utils.dart';
import '/core/helper/helper.dart';

class SplashController extends GetxController {
  final DbHelper _dbHelper;

  SplashController({required DbHelper dbHelper}) : _dbHelper = dbHelper;
  var isLoading = true.obs;
  var showButton = false.obs;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() async {
    try {
      isLoading.value = true;
      // await Future.delayed(const Duration(seconds: 2));
      await _dbHelper.initDatabase('phrases_db', Assets.phrasesDB);
      await _dbHelper.initDatabase('learn_japanese', Assets.learnDB);
    } finally {
      isLoading.value = false;
      showButton.value = true;
    }
  }
}
