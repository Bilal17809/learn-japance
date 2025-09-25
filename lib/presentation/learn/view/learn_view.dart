import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/theme/theme.dart';
import '/core/common_widgets/common_widgets.dart';
import '/core/constants/constants.dart';
import '/presentation/learn/controller/learn_controller.dart';
import '/ad_manager/ad_manager.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<InterstitialAdManager>().checkAndDisplayAd();
    });
    final controller = Get.find<LearnController>();
    controller.setTopic(topicId);
    return Scaffold(
      appBar: TitleBar(title: '$category - $japCategory'),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.secondaryIcon(context),
            ),
          );
        }
        final data = controller.data;
        return SafeArea(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: kBodyHp,
              vertical: kGap,
            ),
            itemCount: data.length + 1,
            itemBuilder: (context, index) {
              if (index == 3) {
                return NativeAdWidget();
              }
              final dataIndex = index > 3 ? index - 1 : index;
              return ClipPath(
                clipper: TicketClipper(),
                child: Container(
                  margin: const EdgeInsets.only(bottom: kElementGap),
                  decoration: AppDecorations.rounded(context),
                  child: ListTile(
                    title: Text(
                      data.elementAt(dataIndex).english.toString(),
                      style: titleSmallStyle,
                    ),
                    subtitle: Text(
                      data.elementAt(dataIndex).japanese.toString(),
                      style: titleSmallStyle,
                    ),
                    trailing: IconActionButton(
                      onTap:
                          () => controller.onSpeak(
                            data.elementAt(dataIndex).japanese.toString(),
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
