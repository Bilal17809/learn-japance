import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:learn_japan/core/theme/app_styles.dart';
import 'package:lottie/lottie.dart';
import '/core/utils/utils.dart';
import '/presentation/translator/controller/translator_controller.dart';
import '/core/common_widgets/common_widgets.dart';
import '/core/constants/constants.dart';
import 'widgets/language_dropdown.dart';
import 'widgets/translator_card.dart';

class TranslatorView extends StatelessWidget {
  const TranslatorView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TranslatorController>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: TitleBar(title: 'Translator'),
      body: SafeArea(
        child: Obx(() {
          return Padding(
            padding: const EdgeInsets.all(kBodyHp),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    LanguageDropdown(
                      selected: controller.sourceLanguage.value,
                      languages: controller.allLanguages,
                      onChanged: (lng) => controller.setSource(lng),
                    ),
                    Gap(context.screenWidth * 0.2),
                    LanguageDropdown(
                      selected: controller.targetLanguage.value,
                      languages: controller.allLanguages,
                      onChanged: (lng) => controller.setTarget(lng),
                    ),
                  ],
                ),
                const Gap(kElementGap),
                TranslatorCard(
                  mainText: controller.sourceLanguage.value?.name,
                  leftIcon: Icons.volume_up,
                  centerIcon: Icons.mic,
                  rightIcon: Icons.send,
                  onLeftPressed: () {},
                  onCenterPressed: () {},
                  onRightPressed: () {
                    controller.translateInput();
                  },
                  canWrite: true,
                ),
                const Gap(kElementGap),
                if (controller.translatedText.value.isNotEmpty) ...[
                  TranslatorCard(
                    mainText: controller.targetLanguage.value?.name,
                    leftIcon: Icons.volume_up,
                    centerIcon: Icons.copy,
                    rightIcon: Icons.history,
                    onLeftPressed: () {},
                    onCenterPressed: () {
                      Clipboard.setData(
                        ClipboardData(text: controller.translatedText.value),
                      );
                    },
                    onRightPressed: () {},
                    canWrite: false,
                  ),
                ] else ...[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Opacity(
                          opacity: 0.5,
                          child: Lottie.asset(
                            Assets.translationLottie,
                            width: context.screenWidth * 0.35,
                          ),
                        ),
                        Text(
                          'Submit text to show translation',
                          style: bodyLargeStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          );
        }),
      ),
    );
  }
}
