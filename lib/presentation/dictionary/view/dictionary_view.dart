import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/common_widgets/common_widgets.dart';
import '/presentation/dictionary/controller/dictionary_controller.dart';

class DictionaryView extends StatelessWidget {
  const DictionaryView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DictionaryController>();
    return Scaffold(
      appBar: TitleBar(title: 'Dictionary'),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.translationsLoading.value &&
            controller.wordsTranslations.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          ); // translation-level loader
        }

        return ListView.builder(
          itemCount: controller.dictionaryData.length,
          itemBuilder: (context, index) {
            final item = controller.dictionaryData[index];
            final hasTranslation = index < controller.wordsTranslations.length;

            return ListTile(
              title: Text(item.english),
              subtitle: Text(
                hasTranslation
                    ? controller.wordsTranslations[index]
                    : "Translating...",
              ),
            );
          },
        );
      }),
    );
  }
}
