import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restart_app/restart_app.dart';
import '../common_widgets/common_widgets.dart';
import '../constants/constants.dart';
import '../local_storage/local_storage.dart';
import '../theme/theme.dart';

class ResetUtil {
  static void showResetDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
          title: const Text("Reset App"),
          content: const Text(
            "Are you sure you want to reset the app?"
            "This will clear all saved progress and preferences.",
          ),
          actions: [
            AppDialogButton(
              text: "Cancel",
              onPressed: () => Navigator.of(context).pop(),
            ),
            AppDialogButton(
              text: "Reset",
              textColor: AppColors.kRed,
              onPressed: () async {
                await Get.find<LocalStorage>().clear();
                Restart.restartApp();
              },
            ),
          ],
        );
      },
    );
  }
}
