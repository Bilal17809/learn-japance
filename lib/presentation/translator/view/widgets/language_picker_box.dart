import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '/presentation/language_picker/view/language_picker_view.dart';
import '/data/models/models.dart';
import '/core/constants/constants.dart';
import '/core/theme/theme.dart';

class LanguagePickerBox extends StatelessWidget {
  final LanguageModel? selected;
  final List<LanguageModel> languages;
  final ValueChanged<LanguageModel> onChanged;

  const LanguagePickerBox({
    super.key,
    required this.selected,
    required this.languages,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GestureDetector(
        onTap: () {
          Get.to(
            () => LanguagePickerView(
              languages: languages,
              selected: selected,
              onSelected: onChanged,
            ),
          );
        },
        child: Container(
          width: context.screenWidth * 0.4,
          padding: const EdgeInsets.all(kGap),
          decoration: AppDecorations.rounded(context).copyWith(
            color: AppColors.primary(context),
            border: Border.all(color: AppColors.secondary(context)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (selected != null) ...[
                Text(selected!.flagEmoji, style: titleLargeStyle),
                const Gap(kGap),
                Expanded(
                  child: Text(
                    selected!.name.split(" ").first,
                    style: titleSmallStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ] else
                Text("Select", style: titleSmallStyle),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
    );
  }
}
