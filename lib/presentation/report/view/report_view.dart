import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_japan/core/theme/theme.dart';
import '/core/global_keys/global_key.dart';
import '/core/common_widgets/common_widgets.dart';
import '/core/constants/constants.dart';
import '/core/utils/utils.dart';
import 'package:lottie/lottie.dart';
import '../controller/report_controller.dart';

class ReportView extends StatelessWidget {
  const ReportView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ReportController>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: TitleBar(title: 'Report an Issue'),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              left: kBodyHp,
              right: kBodyHp,
              top: 0,
              bottom: MediaQuery.of(context).viewInsets.bottom + kBodyHp,
            ),
            child: Column(
              spacing: kElementGap,
              children: [
                Lottie.asset(
                  Assets.reportLottie,
                  width: context.screenWidth * 0.41,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Name ', style: titleMediumStyle),
                    Expanded(
                      child: Text(
                        '*',
                        style: titleMediumStyle.copyWith(color: AppColors.kRed),
                      ),
                    ),
                  ],
                ),
                InputField(
                  controller: controller.nameController,
                  hintText: "Enter your name",
                  textStyle: bodyLargeStyle,
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(kBorderRadius),
                    ),
                    borderSide: BorderSide(color: AppColors.kBlack),
                  ),
                  validator:
                      (val) =>
                          val == null || val.trim().isEmpty
                              ? "Name is required"
                              : null,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Error Type ', style: titleMediumStyle),
                    Expanded(
                      child: Text(
                        '*',
                        style: titleMediumStyle.copyWith(color: AppColors.kRed),
                      ),
                    ),
                  ],
                ),
                Obx(
                  () => DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(kBorderRadius),
                      ),
                      contentPadding: const EdgeInsets.all(kGap),
                    ),
                    hint: const Text("Choose an error type"),
                    initialValue: controller.selectedError.value,
                    items:
                        controller.errors
                            .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)),
                            )
                            .toList(),
                    onChanged:
                        (value) => controller.selectedError.value = value,
                    validator:
                        (value) =>
                            value == null
                                ? "Please select an error type"
                                : null,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Description ', style: titleMediumStyle),
                    Expanded(
                      child: Text(
                        '*',
                        style: titleMediumStyle.copyWith(color: AppColors.kRed),
                      ),
                    ),
                  ],
                ),
                InputField(
                  controller: controller.descriptionController,
                  hintText: "Enter description",
                  minLines: 5,
                  maxLines: 5,
                  textStyle: bodyLargeStyle,
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(kBorderRadius),
                    ),
                    borderSide: BorderSide(color: AppColors.kBlack),
                  ),
                  validator:
                      (val) =>
                          val == null || val.trim().isEmpty
                              ? "Description is required"
                              : null,
                ),
                AppElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      controller.sendReport();
                    }
                  },
                  icon: Icons.send,
                  label: 'Send Report',
                  width: double.infinity,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
