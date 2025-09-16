import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:learn_japan/presentation/translator/controller/translator_controller.dart';
import '/core/constants/constants.dart';
import '/core/common_widgets/buttons.dart';
import '/core/services/services.dart';
import '/core/theme/theme.dart';
import '/core/utils/utils.dart';

class SpeechDialog extends StatelessWidget {
  const SpeechDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final speechService = Get.find<SpeechService>();
    final translatorController = Get.find<TranslatorController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final locale =
          translatorController.sourceLanguage.value?.ttsCode ?? 'en_US';
      speechService.startListeningWithDialog(locale: locale);
    });

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && speechService.isListening.value) {
          speechService.stopListening();
        }
      },
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.symmetric(
              vertical: kBodyHp * 1.25,
              horizontal: kElementGap,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  SpeechUtil.getStatusText(speechService),
                  style: titleLargeStyle.copyWith(fontWeight: FontWeight.w500),
                ),
                const Gap(kBodyHp),
                if (speechService.recognizedText.value.isNotEmpty) ...[
                  Text(
                    speechService.recognizedText.value,
                    style: bodyMediumStyle,
                    textAlign: TextAlign.center,
                  ),
                ],
                const Gap(kGap),
                IconActionButton(
                  onTap: () {
                    if (speechService.isListening.value) {
                      speechService.stopListening();
                    } else {
                      final locale =
                          translatorController.sourceLanguage.value?.ttsCode ??
                          'en-US';
                      speechService.startListeningWithDialog(locale: locale);
                    }
                  },
                  isCircular: true,
                  icon: SpeechUtil.getMicrophoneIcon(speechService),
                  color: SpeechUtil.getMicrophoneColor(speechService),
                ),
                const Gap(kBodyHp),
                Text(
                  SpeechUtil.getHintText(speechService),
                  style: context.textTheme.bodySmall?.copyWith(
                    color: AppColors.textGreyColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Gap(kBodyHp),
                Row(
                  children: [
                    Expanded(
                      child: AppElevatedButton(
                        onPressed: () {
                          if (speechService.isListening.value) {
                            speechService.stopListening();
                          }
                          Navigator.of(context).pop();
                        },
                        icon: Icons.cancel,
                        width: double.infinity,
                        label: 'Cancel',
                      ),
                    ),
                    const Gap(kElementGap),
                    if (speechService.recognizedText.value.trim().isNotEmpty)
                      Expanded(
                        child: AppElevatedButton(
                          onPressed:
                              () =>
                                  SpeechUtil.submitText(context, speechService),
                          icon: Icons.chevron_right,
                          width: double.infinity,
                          label: 'Use Text',
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
