import 'package:flutter/material.dart';
import '/core/common_widgets/common_widgets.dart';
import '/core/constants/constants.dart';
import 'package:gap/gap.dart';
import '/data/models/models.dart';
import '/core/theme/theme.dart';

class ItemCard extends StatelessWidget {
  final ItemsModel item;
  final double? width;
  final double? height;

  const ItemCard({super.key, required this.item, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: ImageActionButton(
            width: width ?? primaryIcon(context) * 2,
            // height: height ?? primaryIcon(context) * 2,
            assetPath: item.assetPath,
            backgroundColor: AppColors.container(context),
            padding: const EdgeInsets.all(kBodyHp),
            size: primaryIcon(context),
            color: AppColors.primary(context),
          ),
        ),
        const Gap(kGap),
        SizedBox(
          width: 60,
          child: Text(
            item.label ?? '',
            textAlign: TextAlign.center,
            style: bodyMediumStyle.copyWith(fontWeight: FontWeight.w600),
            maxLines: 2,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
