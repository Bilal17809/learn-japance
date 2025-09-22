import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/common_widgets/common_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportController extends GetxController {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final selectedError = RxnString();
  final List<String> errors = [
    "App Crashing",
    "Ads Not Working",
    "Content Issue",
    "Slow Performance",
    "UI Glitching",
    "App Freezing",
    "Wrong Answer/Misinformation",
    "Audio Not Working",
    "Payment/Subscription Issue",
    "Other",
  ];
  final String reportEmail = "unisoftaps@gmail.com";

  Future<void> sendReport() async {
    if (nameController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        selectedError.value == null) {
      SimpleToast.showCustomToast(
        context: Get.context!,
        message: "Please fill all fields before submitting",
      );
      return;
    }
    final String subject = "Bug Report: ${selectedError.value}";
    final String body =
        "Name: ${nameController.text}\n\n"
        "Error: ${selectedError.value}\n\n"
        "Description:\n${descriptionController.text}";
    final Uri emailUri = Uri.parse(
      "mailto:$reportEmail?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}",
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      SimpleToast.showCustomToast(
        context: Get.context!,
        message: "Could not launch email app",
      );
    }
  }
}
