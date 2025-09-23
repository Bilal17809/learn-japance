import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/theme/theme.dart';
import '/presentation/jws/view/widgets/tab_view_sections.dart';
import '/core/common_widgets/common_widgets.dart';
import '/presentation/jws/controller/jws_controller.dart';
import '/ad_manager/ad_manager.dart';

class JwsView extends StatelessWidget {
  final String selectedWord;
  JwsView({super.key, required this.selectedWord});
  final controller = Get.find<JwsController>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<InterstitialAdManager>().checkAndDisplayAd();
    });
    controller.setArguments(selectedWord);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: TitleBar(
          title: 'JWS - 日本の文字体系',
          bottom: TabBar(
            tabs: [
              Tab(child: Text("Hiragana", style: titleMediumStyle)),
              Tab(child: Text("Katakana", style: titleMediumStyle)),
              Tab(child: Text("Kanji", style: titleMediumStyle)),
            ],
            isScrollable: false,
            unselectedLabelColor: AppColors.secondaryText(context),
            labelColor: AppColors.primaryText(context),
            indicatorColor: AppColors.primaryText(context),
          ),
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.secondaryIcon(context),
              ),
            );
          }
          return SafeArea(child: TabViewSections());
        }),
        bottomNavigationBar: Obx(() {
          final interstitial = Get.find<InterstitialAdManager>();
          return interstitial.isShow.value
              ? const SizedBox()
              : const BannerAdWidget();
        }),
      ),
    );
  }
}
