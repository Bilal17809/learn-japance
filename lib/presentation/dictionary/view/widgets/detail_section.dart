import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:learn_japan/data/models/models.dart';
import '/presentation/dictionary/view/widgets/ai_section.dart';
import '/core/theme/theme.dart';
import '/core/constants/constants.dart';
import '/core/common_widgets/common_widgets.dart';
import '/presentation/dictionary/controller/dictionary_controller.dart';

class DetailSection extends StatelessWidget {
  final DictionaryModel selected;
  const DetailSection({super.key, required this.selected});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DictionaryController>();

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(kBodyHp),
            decoration: AppDecorations.rounded(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.menu_book_rounded,
                          size: secondaryIcon(context),
                        ),
                        const SizedBox(width: kGap),
                        Text('Word:', style: titleSmallStyle),
                      ],
                    ),
                    Row(
                      children: [
                        IconActionButton(
                          tooltip: 'Speak',
                          onTap: () => controller.onSpeak(selected.japanese),
                          icon: Icons.volume_up,
                        ),
                        const SizedBox(width: kGap),
                        IconActionButton(
                          tooltip: 'Copy All',
                          onTap:
                              () => Clipboard.setData(
                                ClipboardData(
                                  text:
                                      '${selected.english}\n${selected.japanese}',
                                ),
                              ),
                          icon: Icons.copy,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: kGap),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('English:', style: titleSmallStyle),
                    const SizedBox(width: kGap),
                    Expanded(
                      child: Text(selected.english, style: titleSmallStyle),
                    ),
                  ],
                ),
                const SizedBox(height: kGap),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Japanese:', style: titleSmallStyle),
                    const SizedBox(width: kGap),
                    Expanded(child: Text(selected.japanese)),
                  ],
                ),
              ],
            ),
          ),
          const Gap(kElementGap),
          AiSection(),
        ],
      ),
    );
  }
}
