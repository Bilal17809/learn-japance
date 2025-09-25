import 'package:flutter/material.dart';
import '/core/common_widgets/common_widgets.dart';
import '/core/theme/theme.dart';

class ExitDialog {
  static Future<bool?> show(BuildContext context) async {
    return AppAlertDialog.show<bool>(
      context: context,
      barrierDismissible: false,
      title: "Exit App",
      content: const Text("Are you sure you want to exit the app?"),
      actions: [
        AppDialogButton(
          text: "Cancel",
          onPressed: () => Navigator.of(context).pop(false),
        ),
        AppDialogButton(
          text: "Exit",
          textColor: AppColors.kRed,
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    );
  }
}
