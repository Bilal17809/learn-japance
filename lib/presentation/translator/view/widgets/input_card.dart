import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '/presentation/translator/controller/translator_controller.dart';
import '/core/common_widgets/common_widgets.dart';
import '/core/constants/constants.dart';
import '/core/theme/theme.dart';

class InputCard extends StatelessWidget {
  final String? mainText;
  final IconData leftIcon;
  final IconData centerIcon;
  final IconData rightIcon;
  final VoidCallback? onLeftPressed;
  final VoidCallback? onCenterPressed;
  final VoidCallback? onRightPressed;

  const InputCard({
    super.key,
    this.mainText,
    required this.leftIcon,
    required this.centerIcon,
    required this.rightIcon,
    this.onLeftPressed,
    this.onCenterPressed,
    this.onRightPressed,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TranslatorController>();
    return Container(
      height: context.screenHeight * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kBorderRadius),
        color: AppColors.secondary(context),
      ),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(kGap),
              child: Obx(
                () => Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: primaryIcon(context)),
                      child: TextField(
                        style: bodyLargeStyle,
                        controller: controller.inputController,
                        textDirection:
                            controller.inputText.value.isNotEmpty
                                ? (controller.isSourceRtl.value
                                    ? TextDirection.rtl
                                    : TextDirection.ltr)
                                : TextDirection.ltr,
                        textAlign:
                            controller.inputText.value.isNotEmpty
                                ? (controller.isSourceRtl.value
                                    ? TextAlign.right
                                    : TextAlign.left)
                                : TextAlign.left, // hint stays left
                        onChanged: (val) => controller.inputText.value = val,
                        maxLength: 200,
                        maxLines: 10,
                        decoration: InputDecoration(
                          hintText: 'Enter text to translate',
                          border: InputBorder.none,
                          counterText: '',
                        ),
                      ),
                    ),
                    if (controller.inputText.isNotEmpty)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconActionButton(
                          icon: Icons.cancel,
                          onTap: () {
                            controller.inputController.clear();
                            controller.inputText.value = '';
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          const Gap(kGap),
          Container(
            width: double.infinity,
            // color: AppColors.primary(context),
            decoration: BoxDecoration(
              color: AppColors.primary(context),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(kBorderRadius),
                bottomRight: Radius.circular(kBorderRadius),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconActionButton(onTap: onLeftPressed!, icon: leftIcon),
                IconActionButton(onTap: onCenterPressed!, icon: centerIcon),
                IconActionButton(onTap: onRightPressed!, icon: rightIcon),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
