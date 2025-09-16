import 'package:flutter/material.dart';
import '../common_widgets/common_widgets.dart';
import '../constants/constants.dart';
import '/core/theme/theme.dart';

class HomeDialogs {
  static Future<bool?> showExitDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
          title: const Text("Exit App"),
          content: const Text("Are you sure you want to exit the app?"),
          actions: [
            AppDialogButton(
              text: "Cancel",
              onPressed: () => Navigator.of(context).pop(),
            ),
            AppDialogButton(
              text: "Exit",
              textColor: AppColors.kRed,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }
}
