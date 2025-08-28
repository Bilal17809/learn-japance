import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:learn_japan/data/models/models.dart';
import '/core/common/app_exceptions.dart';
import '/core/services/services.dart';

class ConvoCatController extends GetxController {
  final DbService _convoDbService;

  ConvoCatController({required DbService convoDbService})
    : _convoDbService = convoDbService;

  final isLoading = true.obs;
  var topics = <ConvoModel>[].obs;
  var error = ''.obs;

  @override
  onInit() {
    super.onInit();
    _fetchDb();
  }

  Future<void> _fetchDb() async {
    isLoading.value = true;
    try {
      await Future.delayed(const Duration(milliseconds: 350));
      error.value = '';
      final result = await _convoDbService.getAllConvo();
      topics.assignAll(result);
      print('###########################Topics: $topics');
    } catch (e) {
      debugPrint('${AppExceptions().failToLoadDb}: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
