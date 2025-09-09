import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '/core/theme/theme.dart';
import '/core/constants/constants.dart';
import '/core/common_widgets/common_widgets.dart';
import '/presentation/dictionary/controller/dictionary_controller.dart';

class WordsList extends StatelessWidget {
  final TextEditingController searchController;
  final List data;
  const WordsList({
    super.key,
    required this.data,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DictionaryController>();

    return ListView.builder(
      itemCount: data.length,
      padding: const EdgeInsets.symmetric(horizontal: kBodyHp),
      itemBuilder: (context, index) {
        if (index < 0 || index >= data.length) {
          return const SizedBox.shrink();
        }

        final item = data[index];

        return ClipPath(
          clipper: TicketClipper(),
          child: GestureDetector(
            onTap: () {
              controller.selectedWord.value = item;
              searchController.clear();
              Get.focusScope?.unfocus();
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: kGap),
              padding: const EdgeInsets.all(kBodyHp),
              decoration: AppDecorations.rounded(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.english,
                    style: titleMediumStyle.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Gap(kGap),
                  Text(
                    item.japanese,
                    style: titleMediumStyle.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
