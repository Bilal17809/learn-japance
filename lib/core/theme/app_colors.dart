import 'package:flutter/material.dart';
import 'theme.dart';

class AppColors {
  /// Base Colors
  static const Color transparent = Colors.transparent;

  // Whites / Blacks / Greys
  static const Color kWhite = Color(0xFFFFFFFF);
  static const Color kBlack = Color(0xFF1C1C1C);
  static const Color kGrey = Color(0xFF757575);

  // Reds
  static const Color kRed = Color(0xffe30000);

  // Blues
  static const Color kSkyBlue = Color(0xFF90CAF9);

  // Greens
  static const Color kGreen = Color(0xff02ba1b);

  // Text
  static const Color textBlackColor = Color(0xFF000000);
  static const Color textWhiteColor = Color(0xFFE8E7E7);
  static const Color textGreyColor = Color(0xff7e7d7d);

  // Primary
  static const Color primaryColorLight = Color(0xFFEEAE4F);
  static const Color primaryColorDark = Color(0xFF181818);

  // Secondary
  static const Color secondaryColorLight = Color(0xFFFFECC9);
  static const Color secondaryColorDark = Color(0xff9a9a9a);

  // Background
  static const Color lightBgColor = Color(0xFFEFD8DA);
  static const Color darkBgColor = Color(0xFF121212);

  /// Getters
  static Color primary(BuildContext context) =>
      context.isDark ? secondaryColorDark : primaryColorLight;

  static Color secondary(BuildContext context) =>
      context.isDark ? kWhite.withValues(alpha: 0.1) : secondaryColorLight;

  static Color primaryText(BuildContext context) =>
      context.isDark ? textWhiteColor : textBlackColor;

  static Color secondaryText(BuildContext context) =>
      context.isDark ? kWhite.withValues(alpha: 0.7) : textGreyColor;

  static Color container(BuildContext context) =>
      context.isDark ? kWhite.withValues(alpha: 0.1) : kWhite;

  static Color icon(BuildContext context) => context.isDark ? kWhite : kGrey;

  static Color secondaryIcon(BuildContext context) =>
      context.isDark ? kWhite : primaryColorLight;

  Color getBgColor(BuildContext context) =>
      context.isDark ? darkBgColor : lightBgColor;
}
