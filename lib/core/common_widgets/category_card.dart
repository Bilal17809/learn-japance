import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'common_widgets.dart';
import '/core/theme/theme.dart';
import '/core/constants/constants.dart';
import '/data/models/models.dart';

class CategoryCard extends StatelessWidget {
  final String category;
  final String? translatedCategory;
  final ItemsModel item;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.category,
    this.translatedCategory,
    required this.onTap,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: WavyClipper(),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: AppDecorations.rounded(context),
          padding: const EdgeInsets.all(kElementGap),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: ImageActionButton(
                    padding: const EdgeInsets.all(kGap),
                    assetPath: item.assetPath,
                    isCircular: true,
                    backgroundColor: AppColors.secondary(Get.context!),
                    color: AppColors.primary(context),
                    size: primaryIcon(context),
                  ),
                ),
              ),
              const Gap(kGap),
              Expanded(
                child: Wrap(
                  children: [
                    Text(
                      translatedCategory!,
                      textAlign: TextAlign.center,
                      style: titleMediumStyle.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const Gap(kElementGap),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  category,
                  textAlign: TextAlign.center,
                  style: titleMediumStyle.copyWith(fontWeight: FontWeight.w500),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
