import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/common_widgets/common_widgets.dart';
import '/core/constants/constants.dart';
import '/presentation/grammar/controller/grammar_controller.dart';
import 'widgets/japanese_card.dart';

class GrammarView extends StatelessWidget {
  final String selectedCategory;

  const GrammarView({super.key, required this.selectedCategory});

  @override
  Widget build(BuildContext context) {
    final GrammarController controller = Get.put(GrammarController());

    return Scaffold(
      appBar: TitleBar(title: selectedCategory),
      body: Obx(() {
        if (controller.splashController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        final data = controller.getFilteredData(selectedCategory);
        return SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kBodyHp),
                child: SearchBarField(
                  controller: controller.searchController,
                  onSearch: (value) => controller.searchQuery.value = value,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kBodyHp,
                    vertical: kGap,
                  ),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return JapaneseCard(
                      item: data[index],
                      controller: controller,
                      index: index,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
