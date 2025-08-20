import 'package:flutter/material.dart';
import 'theme.dart';

class AppColors {
  /// Colors
  static const Color transparent = Colors.transparent;
  // Whites
  static const Color kWhite = Color(0xFFFFFFFF);
  // Blacks
  static const Color kBlack = Color(0xFF1C1C1C);
  static const Color kGrey = Color(0xFFA1A1A1);
  // Reds
  static const Color kRed = Color(0xffe30000);
  // Greens
  static const Color kGreen = Color(0xff55ff00);
  // Text colors
  static const Color textBlackColor = Color(0xFF000000);
  static const Color textWhiteColor = Color(0xFFE8E7E7);
  static const Color textGreyColor = Color(0xff7e7d7d);
  // App primary
  static const Color primaryColorLight = Color(0xFFEEAE4F);
  static const Color primaryColorDark = Color(0xFF8F8F8F);
  // App secondary
  static const Color secondaryColorLight = Color(0xFFFFDA97);
  static const Color secondaryColorDark = Color(0xDD082773);
  // App background
  static const Color lightBgColor = Color(0xFFEFD8DA);
  static const Color darkBgColor = Color(0xDD061D5A);

  /// Getters
  static Color primary(BuildContext context) =>
      context.isDark ? primaryColorDark : primaryColorLight;
  static Color secondary(BuildContext context) =>
      context.isDark ? secondaryColorDark : secondaryColorLight;
  // Text Colors
  static Color primaryText(BuildContext context) =>
      context.isDark ? textWhiteColor : textBlackColor;
  static Color secondaryText(BuildContext context) => textGreyColor;
  // Other Colors
  static Color container(BuildContext context) =>
      context.isDark ? kWhite.withValues(alpha: 0.1) : kWhite;
  static Color icon(BuildContext context) => context.isDark ? kWhite : kBlack;
  Color getBgColor(BuildContext context) =>
      context.isDark ? darkBgColor : lightBgColor;
}
