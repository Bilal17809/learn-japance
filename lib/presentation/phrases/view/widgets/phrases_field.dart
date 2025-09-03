import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '/presentation/phrases/controller/phrases_controller.dart';
import '/core/constants/constants.dart';
import '/core/theme/theme.dart';

class PhrasesField extends StatelessWidget {
  final String label, jpLabel, text, cacheKey;
  final IconData icon;
  final bool isExample;
  final PhrasesController controller;

  const PhrasesField({
    super.key,
    required this.label,
    required this.jpLabel,
    required this.text,
    required this.cacheKey,
    required this.icon,
    required this.controller,
    this.isExample = false,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isLoading = controller.translatingStates[cacheKey] == true;
      final translated = controller.translationCache[cacheKey];

      return Container(
        padding: const EdgeInsets.all(kElementGap),
        decoration: AppDecorations.highlight(context, isExample: isExample),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: smallIcon(context),
                  color: AppColors.icon(context),
                ),
                const Gap(kGap),
                Text(
                  "$label ($jpLabel)",
                  style: bodyMediumStyle.copyWith(fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const Gap(kGap),
            Text(text, style: titleSmallStyle),
            const Gap(kGap),
            Row(
              children: [
                Expanded(
                  child:
                      isLoading
                          ? Text(
                            "Translating...",
                            style: bodyLargeStyle.copyWith(
                              color: AppColors.textGreyColor,
                            ),
                          )
                          : translated != null
                          ? Container(
                            padding: const EdgeInsets.all(8),
                            decoration: AppDecorations.highlight(
                              context,
                              isExample: !isExample,
                            ),
                            child: Text(translated, style: bodyLargeStyle),
                          )
                          : const SizedBox.shrink(),
                ),
                // if (!isLoading && translated == null)
                //   IconActionButton(
                //     onTap: () => controller.translateText(cacheKey, text),
                //     icon: Icons.translate,
                //     color: AppColors.primaryText(context),
                //     size: smallIcon(context),
                //   ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
