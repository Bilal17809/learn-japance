import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '/core/constants/constants.dart';
import '/core/common_widgets/common_widgets.dart';
import '/presentation/translator/controller/translator_controller.dart';
import '/ad_manager/ad_manager.dart';

class TransFavView extends StatelessWidget {
  const TransFavView({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<InterstitialAdManager>().checkAndDisplayAd();
    });
    final controller = Get.find<TranslatorController>();
    return Scaffold(
      appBar: TitleBar(title: 'Favorites'),
      body: Obx(
        () => SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              controller.favorites.isEmpty
                  ? Expanded(
                    child: LottieWidget(
                      message: 'Add translations to favorites',
                    ),
                  )
                  : Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(kBodyHp),
                      child: ListView.builder(
                        itemCount: controller.favorites.length,
                        itemBuilder: (context, index) {
                          final item = controller.favorites[index];
                          return TranslationCard(
                            showFav: false,
                            translationId: item.id,
                            inputText: item.input,
                            translatedText: item.output,
                            isSourceRtl: item.isSourceRtl,
                            isTargetRtl: item.isTargetRtl,
                            targetLangCode: item.targetLangCode,
                            onRemove: () => controller.removeFav(item.id),
                          );
                        },
                      ),
                    ),
                  ),
              Expanded(
                child: NativeAdWidget(templateType: TemplateType.medium),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
