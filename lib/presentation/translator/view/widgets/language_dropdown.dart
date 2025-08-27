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
        width: context.screenWidth * 0.4,
        padding: const EdgeInsets.symmetric(horizontal: kGap / 2),
        decoration: AppDecorations.rounded(context).copyWith(
          color: AppColors.primary(context),
          border: Border.all(color: AppColors.secondary(context)),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<LanguageModel>(
            borderRadius: BorderRadius.circular(kBorderRadius / 2),
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
                            Padding(
                              padding: const EdgeInsets.only(left: kGap / 2),
                              child: Text(
                                lng.flagEmoji,
                                style: titleLargeStyle,
                              ),
                            ),
                            const Gap(kGap),
                            Flexible(
                              child: Text(
                                lng.name.split(" ").first,
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
