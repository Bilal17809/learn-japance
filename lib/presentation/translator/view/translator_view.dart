import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '/core/theme/theme.dart';
import '/presentation/translation_favorite/view/translation_favorite_view.dart';
import '/core/services/services.dart';
import '/core/utils/utils.dart';
import '/presentation/translator/controller/translator_controller.dart';
import '/core/common_widgets/common_widgets.dart';
import '/core/constants/constants.dart';
import 'widgets/language_picker_box.dart';
import 'widgets/input_card.dart';
import '/ad_manager/ad_manager.dart';

class TranslatorView extends StatelessWidget {
  const TranslatorView({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<InterstitialAdManager>().checkAndDisplayAd();
    });
    final controller = Get.find<TranslatorController>();
    final tts = Get.find<TtsService>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: TitleBar(
        title: 'Translator',
        actions: [
          IconActionButton(
            onTap: () async {
              await tts.stop();
              Get.to(() => const TransFavView());
            },
            icon: Icons.history,
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.secondaryIcon(context),
              ),
            );
          }
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(kBodyHp),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        LanguagePickerBox(
                          selected: controller.sourceLanguage.value,
                          languages: controller.allLanguages,
                          onChanged: (lang) => controller.setSource(lang),
                        ),
                        IconActionButton(
                          onTap: () {
                            final holder = controller.sourceLanguage.value!;
                            controller.setSource(
                              controller.targetLanguage.value!,
                            );
                            controller.setTarget(holder);
                          },
                          icon: Icons.swap_horiz,
                        ),
                        LanguagePickerBox(
                          selected: controller.targetLanguage.value,
                          languages: controller.allLanguages,
                          onChanged: (lang) => controller.setTarget(lang),
                        ),
                      ],
                    ),
                    const Gap(kElementGap),
                    InputCard(
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
                      onRightPressed: () => controller.translateInput(),
                    ),
                    const Gap(kElementGap),
                    if (controller.translations.isNotEmpty) ...[
                      Expanded(
                        child: ListView.builder(
                          itemCount: controller.translations.length,
                          itemBuilder: (context, index) {
                            final reversedIndex =
                                controller.translations.length - 1 - index;
                            final item = controller.translations[reversedIndex];
                            return TranslationCard(
                              showFav: true,
                              translationId: item.id,
                              inputText: item.input,
                              translatedText: item.output,
                              isSourceRtl: item.isSourceRtl,
                              isTargetRtl: item.isTargetRtl,
                              targetLangCode: item.targetLangCode,
                              onRemove: () => controller.remove(item.id),
                            );
                          },
                        ),
                      ),
                    ] else ...[
                      Expanded(
                        child: LottieWidget(
                          assetPath: Assets.translationLottie,
                          message: 'Submit text to show translation',
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (controller.isTranslating.value)
                Center(
                  child: CircularProgressIndicator(
                    color: AppColors.secondaryIcon(context),
                  ),
                ),
            ],
          );
        }),
      ),
      bottomNavigationBar: Obx(() {
        final interstitial = Get.find<InterstitialAdManager>();
        return interstitial.isShow.value
            ? const SizedBox()
            : const BannerAdWidget();
      }),
    );
  }
}
