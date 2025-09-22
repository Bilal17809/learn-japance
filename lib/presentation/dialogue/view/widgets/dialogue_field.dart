import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import '/presentation/dialogue/controller/dialogue_controller.dart';
import '/core/common_widgets/common_widgets.dart';
import '/core/constants/constants.dart';
import '/core/theme/theme.dart';

class DialgoueField extends StatelessWidget {
  final String text, translated;
  final IconData icon;
  final DialogueController controller;

  const DialgoueField({
    super.key,
    required this.text,
    required this.translated,
    required this.icon,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final textLines = text.split('\n');
    final translatedLines = translated.split('\n');
    return Container(
      padding: const EdgeInsets.all(kGap),
      margin: const EdgeInsets.symmetric(vertical: kGap),
      decoration: AppDecorations.highlight(context, isExample: false),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < textLines.length; i++)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(textLines[i], style: titleSmallStyle),
                const Gap(4),
                if (i < translatedLines.length)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(kGap),
                    margin: const EdgeInsets.only(bottom: kGap),
                    decoration: AppDecorations.highlight(
                      context,
                      isExample: true,
                    ),
                    child: Text(translatedLines[i], style: bodyLargeStyle),
                  ),
              ],
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconActionButton(
                onTap: () => controller.onSpeak(translated),
                icon: Icons.volume_up,
              ),
              IconActionButton(
                onTap:
                    () => Clipboard.setData(
                      ClipboardData(text: '$text\n\n$translated'),
                    ),
                icon: Icons.copy,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
