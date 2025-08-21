import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '/core/theme/theme.dart';
import 'input_field.dart';

class SearchBarField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String value) onSearch;
  final Color backgroundColor;
  final Color borderColor;
  final Color iconColor;
  final Color textColor;
  final String? fontFamily;

  const SearchBarField({
    super.key,
    required this.controller,
    required this.onSearch,
    this.backgroundColor = AppColors.transparent,
    this.borderColor = AppColors.primaryColorLight,
    this.iconColor = AppColors.kWhite,
    this.textColor = AppColors.kBlack,
    this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    return InputField(
      controller: controller,
      hintText: 'Search',
      textStyle: bodyMediumStyle.copyWith(
        color: textColor,
        fontFamily: fontFamily,
        fontWeight: FontWeight.bold,
      ),
      hintStyle: bodyMediumStyle.copyWith(
        color: textColor.withValues(alpha: 0.7),
        fontFamily: fontFamily,
        fontWeight: FontWeight.bold,
      ),
      cursorColor: textColor,
      backgroundColor: backgroundColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kCircularBorderRadius),
        borderSide: BorderSide(color: borderColor),
      ),
      onChanged: onSearch,
      onSubmitted: onSearch,
      prefixIcon: Icon(Icons.search, color: iconColor, size: 24),
    );
  }
}
