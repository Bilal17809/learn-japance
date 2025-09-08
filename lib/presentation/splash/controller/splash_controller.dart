import 'package:get/get.dart';
import '/core/utils/utils.dart';
import '/core/helper/helper.dart';

class SplashController extends GetxController {
  final DbHelper _dbHelper;
  final _isLoading = true.obs;
  var showButton = false.obs;

  SplashController({required DbHelper dbHelper}) : _dbHelper = dbHelper;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() async {
    try {
      _isLoading.value = true;
      // await Future.delayed(const Duration(seconds: 2));
      await _dbHelper.initDatabase('phrases_db', Assets.phrasesDb);
      await _dbHelper.initDatabase('learn_japanese', Assets.learnDb);
      await _dbHelper.initDatabase('dictionary_db', Assets.dictDb);
    } finally {
      _isLoading.value = false;
      showButton.value = true;
    }
  }
}
