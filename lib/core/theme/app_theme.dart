import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'theme.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColorLight,
    scaffoldBackgroundColor: AppColors.lightBgColor,
    colorScheme: ColorScheme.light(
      primary: AppColors.primaryColorLight,
      secondary: AppColors.secondaryColorLight,
      surface: AppColors.lightBgColor,
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryColorDark,
    scaffoldBackgroundColor: AppColors.darkBgColor,
    colorScheme: ColorScheme.dark(
      primary: AppColors.primaryColorDark,
      secondary: AppColors.secondaryColorDark,
      surface: AppColors.darkBgColor,
    ),
  );
}
