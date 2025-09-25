import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restart_app/restart_app.dart';
import '/core/common_widgets/common_widgets.dart';
import '/core/local_storage/local_storage.dart';
import '/core/theme/theme.dart';

class ResetDialog {
  static void showResetDialog(BuildContext context) {
    AppAlertDialog.show(
      context: context,
      title: "Reset App",
      content: const Text(
        "Are you sure you want to reset the app? "
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
  }
}
