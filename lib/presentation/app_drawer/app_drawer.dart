import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '/core/constants/constants.dart';
import '/core/local_storage/local_storage.dart';
import '/core/theme/theme.dart';
import '/core/utils/utils.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Container(
        color: AppColors().getBgColor(context),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: AppDecorations.simpleDecor(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: kElementGap),
                      child: Image.asset(
                        Assets.heroImage,
                        height: primaryIcon(context),
                      ),
                    ),
                  ),
                  const Gap(kGap),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text('Learn Japanese', style: headlineSmallStyle),
                  ),
                ],
              ),
            ),
            DrawerTile(
              icon: Icons.more,
              title: 'More Apps',
              onTap: () {
                DrawerActions.moreApp();
              },
            ),
            Divider(color: AppColors.primaryColorLight.withValues(alpha: 0.1)),
            DrawerTile(
              icon: Icons.privacy_tip_rounded,
              title: 'Privacy Policy',
              onTap: () {
                DrawerActions.privacy();
              },
            ),
            Divider(color: AppColors.primaryColorLight.withValues(alpha: 0.1)),
            DrawerTile(
              icon: Icons.star_rounded,
              title: 'Rate Us',
              onTap: () {
                DrawerActions.rateUs();
              },
            ),
            Divider(color: AppColors.primaryColorLight.withValues(alpha: 0.1)),
            if (Platform.isIOS) ...[
              DrawerTile(
                icon: Icons.star_rounded,
                title: 'Remove Ads',
                onTap: () {
                  // Get.to(PremiumScreen());
                },
              ),
              Divider(
                color: AppColors.primaryColorLight.withValues(alpha: 0.1),
              ),
            ],
            ListTile(
              leading: Icon(
                Icons.dark_mode_rounded,
                size: 24,
                color: AppColors.primaryText(context),
              ),
              title: Text(
                Get.theme.brightness == Brightness.dark
                    ? 'Dark Mode'
                    : 'Light Mode',
                style: titleSmallStyle,
              ),
              trailing: Switch(
                value: Get.isDarkMode,
                onChanged: (value) async {
                  Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
                  await LocalStorage().setBool('isDarkMode', value);
                },
                thumbColor: WidgetStatePropertyAll(
                  AppColors.kGrey.withValues(alpha: 0.7),
                ),
                trackColor: WidgetStatePropertyAll(
                  AppColors.kGrey.withValues(alpha: 0.2),
                ),
                trackOutlineColor: WidgetStatePropertyAll(
                  AppColors.kGrey.withValues(alpha: 0.5),
                ),
                trackOutlineWidth: WidgetStatePropertyAll(1),

                activeThumbImage: AssetImage(Assets.heroImage),
              ),
            ),
            Divider(color: AppColors.primaryColorLight.withValues(alpha: 0.1)),
          ],
        ),
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const DrawerTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 24, color: AppColors.primaryText(context)),
      title: Text(title, style: titleSmallStyle),
      onTap: onTap,
    );
  }
}
