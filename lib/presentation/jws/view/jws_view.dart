import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/theme/theme.dart';
import '/presentation/jws/view/widgets/tab_view_sections.dart';
import '/core/common_widgets/common_widgets.dart';
import '/presentation/jws/controller/jws_controller.dart';

class JwsView extends StatelessWidget {
  final String selectedWord;
  JwsView({super.key, required this.selectedWord});
  final controller = Get.find<JwsController>();

  @override
  Widget build(BuildContext context) {
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
          ),
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return SafeArea(child: TabViewSections());
        }),
      ),
    );
  }
}
