import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../controller/convo_controller.dart';
import '/core/common_widgets/common_widgets.dart';
import '/core/constants/constants.dart';
import '/core/theme/theme.dart';

class ConvoField extends StatelessWidget {
  final String label, jpLabel, text, cacheKey;
  final IconData icon;
  final bool isExample;
  final ConvoController controller;
  final int index;

  const ConvoField({
    super.key,
    required this.label,
    required this.jpLabel,
    required this.text,
    required this.cacheKey,
    required this.icon,
    required this.controller,
    this.isExample = false,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isLoading = controller.translatingStates[cacheKey] == true;
      final translated = controller.translationCache[cacheKey];
      return Container(
        padding: const EdgeInsets.fromLTRB(kGap, kGap, kGap, 0),
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
            Text(text, style: bodyLargeStyle),
            const Gap(kGap),
            Row(
              children: [
                Expanded(
                  child:
                      isLoading
                          ? Text(
                            "Translating...",
                            style: bodyMediumStyle.copyWith(
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
                            child: Text(translated, style: bodyMediumStyle),
                          )
                          : const SizedBox.shrink(),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (!isLoading && translated == null) ...[
                  IconActionButton(
                    onTap: () => controller.translateConversation(index),
                    icon: Icons.translate,
                    color: AppColors.primaryText(context),
                    size: smallIcon(context),
                  ),
                ] else ...[
                  IconActionButton(
                    onTap: () => controller.onSpeak(translated ?? ''),
                    icon: Icons.volume_up,
                    color: AppColors.primaryText(context),
                    size: smallIcon(context),
                  ),
                  if (isExample) ...[
                    IconActionButton(
                      onTap:
                          () => Clipboard.setData(
                            ClipboardData(text: translated ?? ''),
                          ),
                      icon: Icons.copy,
                      color: AppColors.primaryText(context),
                      size: smallIcon(context),
                    ),
                  ] else ...[
                    IconActionButton(
                      onTap: () => controller.clearTranslation(index),
                      icon: Icons.arrow_drop_up,
                      color: AppColors.primaryText(context),
                      size: secondaryIcon(context),
                    ),
                  ],
                ],
              ],
            ),
          ],
        ),
      );
    });
  }
}
