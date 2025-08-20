import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:learn_japan/core/common_widgets/buttons.dart';
import 'package:learn_japan/core/constants/constants.dart';
import '../theme/theme.dart';
import '/data/models/items_model.dart';

class ItemCard extends StatelessWidget {
  final ItemsModel item;

  const ItemCard({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecorations.rounded(context),
      padding: const EdgeInsets.all(kElementGap),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ImageActionButton(
            assetPath: item.assetPath,
            isCircular: true,
            backgroundColor: AppColors.secondary(Get.context!),
            padding: const EdgeInsets.all(kBodyHp),
            size: primaryIcon(context),
          ),
          const Gap(kGap),
          Text(
            item.label,
            textAlign: TextAlign.center,
            style: bodyMediumStyle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
