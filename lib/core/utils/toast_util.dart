import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import '../common_widgets/common_widgets.dart';
import 'package:get/get.dart';
import '../theme/theme.dart';

class ToastUtil {
  void showErrorToast(String msg) => SimpleToast.showCustomToast(
    context: Get.context!,
    message: msg,
    type: ToastificationType.error,
    primaryColor: AppColors.kRed,
    icon: Icons.error_outline,
  );
}
