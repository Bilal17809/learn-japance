import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:learn_japan/core/common_widgets/common_widgets.dart';
import 'package:learn_japan/core/global_keys/global_key.dart';
import 'package:learn_japan/presentation/app_drawer/app_drawer.dart';
import 'package:learn_japan/presentation/home/controller/home_controller.dart';
import '/core/utils/utils.dart';
import '/core/constants/constants.dart';
import 'widgets/menu_grid.dart';

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
          child: Column(children: const [_HeroImage(), MenuGrid()]),
        ),
      ),
    );
  }
}

class _HeroImage extends StatelessWidget {
  const _HeroImage();

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Image.asset(
        Assets.heroImage,
        height: mobileHeight(context) * 0.41,
      ),
    );
  }
}
