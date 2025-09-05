import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_japan/core/constants/constants.dart';
import 'package:learn_japan/core/utils/utils.dart';
import 'package:lottie/lottie.dart';
import '/core/common_widgets/common_widgets.dart';
import '/presentation/dictionary/controller/dictionary_controller.dart';

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

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kBodyHp,
                vertical: kGap,
              ),
              child: SearchBarField(
                controller: searchController,
                onSearch: (val) => controller.searchQuery.value = val,
              ),
            ),
            Expanded(
              child:
                  data.isEmpty
                      ? Lottie.asset(
                        Assets.searchError,
                        width: context.screenWidth * 0.41,
                      )
                      : ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final item = data[index];

                          return ListTile(
                            title: Text(item.english),
                            subtitle: Text(item.japanese),
                          );
                        },
                      ),
            ),
          ],
        );
      }),
    );
  }
}
