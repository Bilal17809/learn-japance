import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/data/models/models.dart';
import '/core/common/app_exceptions.dart';
import '/core/services/services.dart';

class ConvoCatController extends GetxController {
  final ConvoDbService _convoDbService;

  ConvoCatController({required ConvoDbService convoDbService})
    : _convoDbService = convoDbService;

  final isLoading = true.obs;
  var cat = <ConvoModel>[].obs;
  var uniqueCat = <String>[].obs;
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
      final result = await _convoDbService.loadConvoData();
      cat.assignAll(result);
      final unique = result.map((e) => e.cat).toSet().toList();
      uniqueCat.assignAll(unique);
    } catch (e) {
      debugPrint('${AppExceptions().failToLoadDb}: $e');
    } finally {
      isLoading.value = false;
    }
  }

  List<String> getFilteredCat() {
    if (searchQuery.value.isEmpty) {
      return uniqueCat;
    }
    return uniqueCat
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
