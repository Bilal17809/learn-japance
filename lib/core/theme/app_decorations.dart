import 'package:flutter/material.dart';
import 'theme.dart';
import '../constants/constants.dart';

class AppDecorations {
  static BoxDecoration rounded(BuildContext context) => BoxDecoration(
    color: AppColors.container(context),
    borderRadius: BorderRadius.circular(kBorderRadius),
    border: Border.all(color: AppColors.container(context)),
  );
  static BoxDecoration roundedInnerDecor(BuildContext context) => BoxDecoration(
    color: AppColors.secondary(context).withValues(alpha: 0.5),
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
        color: AppColors.kBlack.withValues(alpha: 0.3),
        blurRadius: 6,
        spreadRadius: 1,
        offset: Offset(0, 2),
      ),
    ],
  );

  static BoxDecoration roundedIcon(BuildContext context) => BoxDecoration(
    color: AppColors.secondary(context),
    borderRadius: BorderRadius.circular(kCircularBorderRadius),
  );

  static BoxDecoration list(BuildContext context) => BoxDecoration(
    color: context.isDark ? Colors.black : Colors.white,
    borderRadius: BorderRadius.circular(kBorderRadius),
    boxShadow: const [
      BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
    ],
  );

  static BoxDecoration simpleDecor(BuildContext context) => BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors:
          context.isDark
              ? [
                AppColors.kWhite.withValues(alpha: 0.08),
                AppColors.kWhite.withValues(alpha: 0.06),
              ]
              : [AppColors.secondaryColorLight, AppColors.primaryColorLight],
      stops: const [0.3, 0.95],
    ),
  );

  static BoxDecoration highlight(
    BuildContext context, {
    required bool isExample,
  }) => BoxDecoration(
    color:
        isExample
            ? (context.isDark
                ? AppColors.container(context)
                : AppColors.kSkyBlue.withValues(alpha: 0.6))
            : AppColors.container(context),
    borderRadius: BorderRadius.circular(kBorderRadius),
    border: Border.all(color: AppColors.kSkyBlue),
  );
}
