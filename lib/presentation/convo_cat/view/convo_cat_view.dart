import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/common_widgets/common_widgets.dart';
import '/presentation/convo_cat/controller/convo_cat_controller.dart';

class ConvoCatView extends StatelessWidget {
  const ConvoCatView({super.key});

  @override
  Widget build(BuildContext context) {
    final convoController = Get.find<ConvoCatController>();
    return Scaffold(
      appBar: TitleBar(title: 'Choose Category'),
      body: Obx(() {
        if (convoController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return SafeArea(child: Column(children: [Text('Data Loaded')]));
      }),
    );
  }
}
