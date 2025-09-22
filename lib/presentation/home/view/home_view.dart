import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '/core/common_widgets/common_widgets.dart';
import '/core/global_keys/global_key.dart';
import '../../app_drawer/view/app_drawer.dart';
import '/presentation/home/controller/home_controller.dart';
import '/core/utils/utils.dart';
import 'widgets/menu_list.dart';
import 'widgets/character_card.dart';
import 'widgets/bottom_section.dart';
import 'widgets/home_header.dart';
import '/ad_manager/ad_manager.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, value) async {
        if (didPop) return;
        final shouldExit = await HomeDialogs.showExitDialog(context);
        if (shouldExit == true) SystemNavigator.pop();
      },
      child: Scaffold(
        key: globalDrawerKey,
        drawer: const AppDrawer(),
        onDrawerChanged: (isOpen) {
          homeController.isDrawerOpen.value = isOpen;
        },
        appBar: TitleBar(title: 'Learn Japanese', useBackButton: false),
        body: SafeArea(
          child: Column(
            children: const [
              HomeHeader(),
              CharacterCard(),
              MenuList(),
              BottomSection(),
            ],
          ),
        ),
        bottomNavigationBar: Obx(() {
          final interstitial = Get.find<InterstitialAdManager>();
          return interstitial.isShow.value || homeController.isDrawerOpen.value
              ? const SizedBox()
              : const BannerAdWidget();
        }),
      ),
    );
  }
}
