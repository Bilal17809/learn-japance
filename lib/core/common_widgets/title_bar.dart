import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/theme/theme.dart';
import 'buttons.dart';
import '../constants/constants.dart';

class TitleBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actions;
  final String title;
  final bool useBackButton;
  final VoidCallback? onBackTap;

  const TitleBar({
    super.key,
    required this.title,
    this.useBackButton = true,
    this.actions,
    this.onBackTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                useBackButton
                    ? IconActionButton(
                      isCircular: true,
                      backgroundColor: AppColors.secondary(context),
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        Future.delayed(const Duration(milliseconds: 150), () {
                          if (onBackTap != null) {
                            onBackTap!();
                          } else {
                            Get.back();
                          }
                        });
                      },
                      icon: Icons.arrow_back_ios_new,
                      color: AppColors.icon(context),
                      size: secondaryIcon(context) * 0.6,
                    )
                    : IconActionButton(
                      onTap: () => Scaffold.of(context).openDrawer(),
                      icon: Icons.menu,
                      color: AppColors.icon(context),
                      size: secondaryIcon(context),
                    ),
                Row(mainAxisSize: MainAxisSize.min, children: actions ?? []),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              title,
              style: titleMediumStyle,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
