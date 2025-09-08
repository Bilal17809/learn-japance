import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/data/models/models.dart';
import '/core/common/app_exceptions.dart';
import '/core/services/services.dart';

class ConversationCategoryController extends GetxController {
  final ConversationDbService _conversationDbService;
  final isLoading = true.obs;
  final RxString searchQuery = ''.obs;
  var category = <ConversationModel>[].obs;
  final _uniqueCategory = <String>[].obs;

  ConversationCategoryController({
    required ConversationDbService conversationDbService,
  }) : _conversationDbService = conversationDbService;

  @override
  void onInit() {
    super.onInit();
    _fetchCat();
  }

  Future<void> _fetchCat() async {
    isLoading.value = true;
    try {
      await Future.delayed(const Duration(milliseconds: 250));
      final result = await _conversationDbService.loadData();
      category.assignAll(result);
      final unique = result.map((e) => e.category).toSet().toList();
      _uniqueCategory.assignAll(unique);
    } catch (e) {
      debugPrint('${AppExceptions().failToLoadDb}: $e');
    } finally {
      isLoading.value = false;
    }
  }

  List<String> getFilteredCat() {
    if (searchQuery.value.isEmpty) {
      return _uniqueCategory;
    }
    return _uniqueCategory
        .where(
          (c) =>
              c.toLowerCase().contains(searchQuery.value.toLowerCase().trim()),
        )
        .toList();
  }
}
