import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:learn_japan/core/common_widgets/common_widgets.dart';
import 'package:learn_japan/core/global_keys/global_key.dart';
import 'package:learn_japan/presentation/app_drawer/app_drawer.dart';
import 'package:learn_japan/presentation/home/controller/home_controller.dart';
import '/core/utils/utils.dart';
import '/presentation/Greeting/screen/greeting.dart';
import '/presentation/Starte_learning/screen/start_learning.dart';
import '/presentation/Translator/screen/translator.dart';
import '/presentation/phrases/view/phrases_view.dart';
import '/presentation/learn_japance/screen/learn_japanse.dart';
import '/core/constants/constants.dart';

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
          child: Column(children: const [_HeroImage(), _MenuGrid()]),
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

class _MenuGrid extends StatelessWidget {
  const _MenuGrid();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kBodyHp),
        child: GridView.builder(
          itemCount: ItemsUtil.homeItems.length,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: kElementGap,
            mainAxisSpacing: kElementGap,
            childAspectRatio: 0.85,
          ),
          itemBuilder: (context, index) {
            final item = ItemsUtil.homeItems[index];
            return GestureDetector(
              onTap: () {
                switch (index) {
                  case 0:
                    Get.to(() => StartLearning());
                    break;
                  case 1:
                    Get.to(() => LearnJapanse());
                    break;
                  case 2:
                    Get.to(() => Translator());
                    break;
                  case 3:
                    Get.to(() => Greeting());
                    break;
                  case 4:
                    Get.to(() => PhrasesView());
                    break;
                  default:
                    break;
                }
              },
              child: ItemCard(item: item),
            );
          },
        ),
      ),
    );
  }
}
