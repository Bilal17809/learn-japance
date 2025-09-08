import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '/core/theme/theme.dart';
import '/core/utils/utils.dart';
import '/core/constants/constants.dart';
import '/core/common_widgets/common_widgets.dart';
import '/presentation/translator/controller/translator_controller.dart';

class TransFavView extends StatelessWidget {
  const TransFavView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TranslatorController>();
    return Scaffold(
      appBar: TitleBar(title: 'Favorites'),
      body: Obx(
        () => SafeArea(
          child:
              controller.favorites.isEmpty
                  ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Opacity(
                          opacity: 0.5,
                          child: Lottie.asset(
                            Assets.searchError,
                            width: context.screenWidth * 0.35,
                          ),
                        ),
                        Text(
                          'Add translations to favorites',
                          style: bodyLargeStyle,
                        ),
                      ],
                    ),
                  )
                  : Padding(
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
                          onRemove: () => controller.removeFav(item.id),
                        );
                      },
                    ),
                  ),
        ),
      ),
    );
  }
}
