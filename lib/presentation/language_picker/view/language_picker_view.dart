import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '/core/utils/utils.dart';
import '/presentation/language_picker/controller/language_picker_controller.dart';
import '/data/models/models.dart';
import '/core/theme/theme.dart';
import '/core/constants/constants.dart';
import '/core/common_widgets/common_widgets.dart';

class LanguagePickerView extends StatelessWidget {
  final LanguageModel? selected;
  final ValueChanged<LanguageModel> onSelected;

  const LanguagePickerView({
    super.key,
    required this.selected,
    required List<LanguageModel> languages,
    required this.onSelected,
  }) : _languages = languages;

  final List<LanguageModel> _languages;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      LanguagePickerController(allLanguages: _languages),
    );
    final textController = TextEditingController();

    return Scaffold(
      appBar: TitleBar(title: 'Choose Language'),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kBodyHp),
              child: SearchBarField(
                controller: textController,
                onSearch: controller.search,
              ),
            ),

            Expanded(
              child: Obx(() {
                final languages = controller.filteredLanguages;

                if (languages.isEmpty) {
                  return Center(
                    child: Opacity(
                      opacity: 0.5,
                      child: Lottie.asset(
                        Assets.searchError,
                        width: context.screenWidth * 0.41,
                      ),
                    ),
                  );
                }

                final selectedLanguage =
                    selected == null
                        ? null
                        : languages.firstWhereOrNull(
                          (lang) => lang.code == selected!.code,
                        );

                final otherLanguages =
                    selectedLanguage == null
                        ? languages
                        : languages
                            .where((lang) => lang.code != selected!.code)
                            .toList();

                final combined = [
                  if (selectedLanguage != null) selectedLanguage,
                  ...otherLanguages,
                ];

                return Padding(
                  padding: const EdgeInsets.all(kBodyHp),
                  child: ListView.builder(
                    itemCount: combined.length,
                    itemBuilder: (context, index) {
                      final lang = combined[index];
                      final isSelected = lang.code == selected?.code;

                      return GestureDetector(
                        onTap: () {
                          onSelected(lang);
                          Get.back();
                        },
                        child: Card(
                          color: isSelected ? AppColors.primary(context) : null,
                          child: Padding(
                            padding: const EdgeInsets.all(kBodyHp),
                            child: Row(
                              children: [
                                Text(lang.flagEmoji, style: titleLargeStyle),
                                const Gap(kElementGap),
                                Text(lang.name, style: titleSmallStyle),
                                if (isSelected) ...[
                                  const Spacer(),
                                  Icon(
                                    Icons.check,
                                    color: AppColors.icon(context),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
