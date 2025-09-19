import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '/core/services/services.dart';
import '/core/theme/theme.dart';
import '/presentation/translator/controller/translator_controller.dart';
import '/core/common_widgets/common_widgets.dart';
import '/core/constants/constants.dart';
import 'package:share_plus/share_plus.dart';

class TranslationCard extends StatelessWidget {
  final String translationId;
  final String inputText;
  final String translatedText;
  final bool isSourceRtl;
  final bool isTargetRtl;
  final bool showFav;
  final VoidCallback? onRemove;
  final String targetLangCode;

  const TranslationCard({
    super.key,
    required this.translationId,
    required this.inputText,
    required this.translatedText,
    required this.isSourceRtl,
    required this.isTargetRtl,
    required this.onRemove,
    required this.showFav,
    required this.targetLangCode,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TranslatorController>();
    final tts = Get.find<TtsService>();

    return Obx(
      () => Container(
        margin: const EdgeInsets.only(bottom: kBodyHp),
        decoration: AppDecorations.simpleDecor(context),
        child: Padding(
          padding: const EdgeInsets.all(kGap),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  textDirection:
                      isSourceRtl ? TextDirection.rtl : TextDirection.ltr,
                  textAlign: isSourceRtl ? TextAlign.right : TextAlign.left,
                  inputText,
                  style: bodyLargeStyle,
                ),
              ),
              Divider(color: AppColors.icon(context).withValues(alpha: 0.3)),
              SizedBox(
                width: double.infinity,
                child: Text(
                  textDirection:
                      isTargetRtl ? TextDirection.rtl : TextDirection.ltr,
                  textAlign: isTargetRtl ? TextAlign.right : TextAlign.left,
                  translatedText,
                  style: bodyLargeStyle,
                ),
              ),
              const Gap(kGap / 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconActionButton(
                    onTap: () {
                      final lang = controller.allLanguages.firstWhere(
                        (l) => l.code == targetLangCode,
                      );
                      tts.isSpeaking(translatedText)
                          ? tts.stop()
                          : tts.speak(translatedText, lang);
                    },
                    icon:
                        tts.isSpeaking(translatedText)
                            ? Icons.stop
                            : Icons.volume_up,
                    size: smallIcon(context),
                  ),
                  const Gap(kGap),
                  IconActionButton(
                    onTap:
                        () => Clipboard.setData(
                          ClipboardData(text: translatedText),
                        ),
                    icon: Icons.copy,
                    size: smallIcon(context),
                  ),
                  const Gap(kGap),
                  IconActionButton(
                    onTap: onRemove!,
                    icon: Icons.delete,
                    size: smallIcon(context),
                  ),
                  const Gap(kGap),
                  IconActionButton(
                    onTap: () {
                      SharePlus.instance.share(
                        ShareParams(text: '$inputText\n$translatedText'),
                      );
                    },
                    icon: Icons.share,
                    size: smallIcon(context),
                  ),
                  if (showFav == true) ...[
                    const Gap(kGap),
                    IconActionButton(
                      onTap: () => controller.toggleFav(translationId),
                      icon:
                          controller.isFav(translationId)
                              ? Icons.favorite
                              : Icons.favorite_border,
                      color:
                          controller.isFav(translationId)
                              ? AppColors.kRed
                              : AppColors.icon(context),
                      size: smallIcon(context),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
