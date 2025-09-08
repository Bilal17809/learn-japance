import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '/core/constants/constants.dart';
import '/core/theme/theme.dart';
import '/presentation/dictionary/controller/dictionary_controller.dart';

class DetailSection extends StatelessWidget {
  final DictionaryController controller;
  final String title;
  final String content;

  const DetailSection({
    super.key,
    required this.controller,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text('• $title', style: titleSmallStyle)],
        ),
        const Gap(kElementGap),
        Text(content, style: bodyMediumStyle),
      ],
    );
  }
}
