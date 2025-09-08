import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import '/core/common_widgets/common_widgets.dart';
import '/core/constants/constants.dart';
import '/core/theme/theme.dart';
import '../../controller/conversation_controller.dart';

class ConversationField extends StatelessWidget {
  final String label, jpLabel, text, translated;
  final IconData icon;
  final bool isTransField;
  final ConversationController controller;
  final int index;

  const ConversationField({
    super.key,
    required this.label,
    required this.jpLabel,
    required this.text,
    required this.translated,
    required this.icon,
    required this.controller,
    this.isTransField = false,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(kGap, kGap, kGap, 0),
      decoration: AppDecorations.highlight(context, isExample: isTransField),
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
          Container(
            padding: const EdgeInsets.all(kGap),
            decoration: AppDecorations.highlight(
              context,
              isExample: !isTransField,
            ),
            child: Text(translated, style: bodyMediumStyle),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconActionButton(
                onTap: () => controller.onSpeak(translated),
                icon: Icons.volume_up,
                color: AppColors.primaryText(context),
                size: smallIcon(context),
              ),
              if (isTransField) ...[
                IconActionButton(
                  onTap:
                      () => Clipboard.setData(ClipboardData(text: translated)),
                  icon: Icons.copy,
                  color: AppColors.primaryText(context),
                  size: smallIcon(context),
                ),
              ] else ...[
                IconActionButton(
                  onTap: () => controller.toggleConversation(index),
                  icon:
                      controller.isExpanded(index)
                          ? Icons.arrow_drop_up
                          : Icons.arrow_drop_down,
                  color: AppColors.primaryText(context),
                  size: smallIcon(context),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
