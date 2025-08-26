import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '/presentation/trans_fav/view/trans_fav_view.dart';
import '/core/services/services.dart';
import '/core/theme/theme.dart';
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
    final tts = Get.find<TtsService>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: TitleBar(title: 'Translator'),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
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
                    IconActionButton(
                      onTap: () {
                        final holder = controller.sourceLanguage.value!;
                        controller.setSource(controller.targetLanguage.value!);
                        controller.setTarget(holder);
                      },
                      icon: Icons.swap_horiz,
                      color: AppColors.icon(context),
                    ),
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
                  leftIcon:
                      tts.isSpeaking(controller.inputText.value)
                          ? Icons.stop
                          : Icons.volume_up,
                  centerIcon: Icons.mic,
                  rightIcon: Icons.send,
                  onLeftPressed: () {
                    tts.isSpeaking(controller.inputText.value)
                        ? tts.stop()
                        : tts.speak(
                          controller.inputText.value,
                          controller.sourceLanguage.value,
                        );
                  },
                  onCenterPressed: () => controller.handleSpeechInput(),
                  onRightPressed: () {
                    controller.translateInput();
                  },
                  canWrite: true,
                ),
                const Gap(kElementGap),
                if (controller.translatedText.value.isNotEmpty) ...[
                  TranslatorCard(
                    mainText: controller.targetLanguage.value?.name,
                    leftIcon:
                        tts.isSpeaking(controller.translatedText.value)
                            ? Icons.stop
                            : Icons.volume_up,
                    centerIcon: Icons.copy,
                    rightIcon: Icons.history,
                    onLeftPressed: () {
                      tts.isSpeaking(controller.translatedText.value)
                          ? tts.stop()
                          : tts.speak(
                            controller.translatedText.value,
                            controller.targetLanguage.value,
                          );
                    },
                    onCenterPressed: () {
                      Clipboard.setData(
                        ClipboardData(text: controller.translatedText.value),
                      );
                    },
                    onRightPressed: () => Get.to(() => TransFavView()),
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
