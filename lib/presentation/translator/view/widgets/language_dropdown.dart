import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '/data/models/models.dart';
import '/core/constants/constants.dart';
import '/core/theme/theme.dart';

class LanguageDropdown extends StatelessWidget {
  final LanguageModel? selected;
  final List<LanguageModel> languages;
  final ValueChanged<LanguageModel> onChanged;

  const LanguageDropdown({
    super.key,
    required this.selected,
    required this.languages,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: kGap),
        decoration: AppDecorations.simpleDecor(
          context,
        ).copyWith(borderRadius: BorderRadius.circular(kBorderRadius)),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<LanguageModel>(
            isExpanded: true,
            value: selected,
            dropdownColor: AppColors.secondary(context),
            items:
                languages
                    .map(
                      (lng) => DropdownMenuItem(
                        value: lng,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 30,
                              child: Text(
                                lng.flagEmoji,
                                style: const TextStyle(fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const Gap(kGap),
                            Flexible(
                              child: Text(
                                lng.name,
                                style: titleSmallStyle,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
            onChanged: (lng) {
              if (lng != null) onChanged(lng);
            },
          ),
        ),
      ),
    );
  }
}
