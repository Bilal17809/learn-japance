import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/data/models/models.dart';
import '/core/common/app_exceptions.dart';
import '/core/services/services.dart';

class ConversationCategoryController extends GetxController {
  final ConversationDbService _conversationDbService;

  ConversationCategoryController({
    required ConversationDbService conversationDbService,
  }) : _conversationDbService = conversationDbService;

  final isLoading = true.obs;
  var category = <ConversationModel>[].obs;
  var uniqueCategory = <String>[].obs;
  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _fetchCat();
  }

  Future<void> _fetchCat() async {
    isLoading.value = true;
    try {
      await Future.delayed(const Duration(milliseconds: 250));
      final result = await _conversationDbService.loadConvoData();
      category.assignAll(result);
      final unique = result.map((e) => e.category).toSet().toList();
      uniqueCategory.assignAll(unique);
    } catch (e) {
      debugPrint('${AppExceptions().failToLoadDb}: $e');
    } finally {
      isLoading.value = false;
    }
  }

  List<String> getFilteredCat() {
    if (searchQuery.value.isEmpty) {
      return uniqueCategory;
    }
    return uniqueCategory
        .where(
          (c) =>
              c.toLowerCase().contains(searchQuery.value.toLowerCase().trim()),
        )
        .toList();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
