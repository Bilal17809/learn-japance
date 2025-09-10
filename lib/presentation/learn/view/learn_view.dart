import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_japan/core/theme/theme.dart';
import '/core/common_widgets/common_widgets.dart';
import '/core/constants/constants.dart';
import '/presentation/learn/controller/learn_controller.dart';

class LearnView extends StatelessWidget {
  final int topicId;
  final String category;
  final String? japCategory;
  const LearnView({
    super.key,
    required this.topicId,
    required this.category,
    required this.japCategory,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LearnController>();
    controller.setTopic(topicId);
    return Scaffold(
      appBar: TitleBar(title: '$category - $japCategory'),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        final data = controller.data;
        return SafeArea(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: kBodyHp,
              vertical: kGap,
            ),
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ClipPath(
                clipper: TicketClipper(),
                child: Container(
                  margin: const EdgeInsets.only(bottom: kElementGap),
                  decoration: AppDecorations.rounded(context),
                  child: ListTile(
                    title: Text(
                      data.elementAt(index).english.toString(),
                      style: titleSmallStyle,
                    ),
                    subtitle: Text(
                      data.elementAt(index).japanese.toString(),
                      style: titleSmallStyle,
                    ),
                    trailing: IconActionButton(
                      onTap:
                          () => controller.onSpeak(
                            data.elementAt(index).japanese.toString(),
                          ),
                      icon: Icons.volume_up,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
