import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/constants/constants.dart';
import '/core/common_widgets/common_widgets.dart';
import '/presentation/dictionary/controller/dictionary_controller.dart';
import 'widgets/words_list.dart';
import 'widgets/detail_section.dart';

class DictionaryView extends StatelessWidget {
  const DictionaryView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DictionaryController>();
    final searchController = TextEditingController();
    return Scaffold(
      appBar: TitleBar(title: 'Dictionary'),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        final data = controller.getFilteredData();
        final selected = controller.selectedWord.value;

        return SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kBodyHp,
                  vertical: kGap,
                ),
                child: SearchBarField(
                  controller: searchController,
                  onSearch: (val) {
                    controller.searchQuery.value = val;
                    controller.selectedWord.value = null;
                  },
                ),
              ),
              Expanded(
                child:
                    selected != null
                        ? Padding(
                          padding: const EdgeInsets.all(kBodyHp),
                          child: DetailSection(selected: selected),
                        )
                        : data.isEmpty
                        ? LottieWidget()
                        : WordsList(
                          data: data,
                          searchController: searchController,
                        ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
