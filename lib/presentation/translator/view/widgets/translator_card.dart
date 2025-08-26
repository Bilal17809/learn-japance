import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '/presentation/translator/controller/translator_controller.dart';
import '/core/common_widgets/common_widgets.dart';
import '/core/constants/constants.dart';
import '/core/theme/theme.dart';

class TranslatorCard extends StatelessWidget {
  final String? mainText;
  final IconData leftIcon;
  final IconData centerIcon;
  final IconData rightIcon;
  final bool canWrite;
  final VoidCallback? onLeftPressed;
  final VoidCallback? onCenterPressed;
  final VoidCallback? onRightPressed;

  const TranslatorCard({
    super.key,
    this.mainText,
    required this.leftIcon,
    required this.centerIcon,
    required this.rightIcon,
    this.onLeftPressed,
    this.onCenterPressed,
    this.onRightPressed,
    required this.canWrite,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TranslatorController>();
    return Flexible(
      child: Container(
        height: context.screenHeight * 0.3,
        color: AppColors.secondary(context),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconActionButton(
                icon: Icons.clear_all,
                color: AppColors.icon(context),
                onTap: () {
                  if (canWrite) {
                    controller.inputController.clear();
                    controller.inputText.value = '';
                  } else {
                    controller.translatedText.value = '';
                  }
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kGap),
                child:
                    canWrite
                        ? Obx(
                          () => TextField(
                            style: bodyLargeStyle,
                            controller: controller.inputController,
                            readOnly: !canWrite,
                            textDirection:
                                controller.isSourceRtl.value
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                            textAlign:
                                controller.isSourceRtl.value
                                    ? TextAlign.right
                                    : TextAlign.left,
                            onChanged:
                                (val) => controller.inputText.value = val,
                            maxLength: 200,
                            maxLines: 10,
                            decoration: const InputDecoration(
                              hintText: 'Enter text to translate',
                              border: InputBorder.none,
                            ),
                          ),
                        )
                        : Obx(
                          () => SizedBox(
                            width: double.infinity,
                            child: Text(
                              textDirection:
                                  controller.isTargetRtl.value
                                      ? TextDirection.rtl
                                      : TextDirection.ltr,
                              textAlign:
                                  controller.isTargetRtl.value
                                      ? TextAlign.right
                                      : TextAlign.left,
                              controller.translatedText.value,
                              style: bodyLargeStyle,
                            ),
                          ),
                        ),
              ),
            ),
            const Gap(kGap),
            Container(
              width: double.infinity,
              color: AppColors.primary(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconActionButton(
                    onTap: onLeftPressed,
                    icon: leftIcon,
                    color: AppColors.icon(context),
                  ),
                  IconActionButton(
                    onTap: onCenterPressed,
                    icon: centerIcon,
                    color: AppColors.icon(context),
                  ),
                  IconActionButton(
                    onTap: onRightPressed,
                    icon: rightIcon,
                    color: AppColors.icon(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
