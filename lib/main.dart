import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '/core/services/services.dart';
import '/presentation/splash/view/splash_view.dart';
import 'package:toastification/toastification.dart';
import '/core/local_storage/local_storage.dart';
import 'core/binders/dependency_injection.dart';
import 'core/theme/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MobileAds.instance.initialize();
  DependencyInjection.init();
  OnesignalService.init();
  WidgetsBinding.instance.addObserver(Get.find<OnCloseService>());
  final storage = LocalStorage();
  final isDark = await storage.getBool('isDarkMode');
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    LearnJapanese(
      themeMode:
          isDark == true
              ? ThemeMode.dark
              : isDark == false
              ? ThemeMode.light
              : ThemeMode.system,
    ),
  );
}

class LearnJapanese extends StatelessWidget {
  final ThemeMode themeMode;
  const LearnJapanese({super.key, required this.themeMode});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Learn Japanese',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeMode,
        home: SplashView(),
      ),
    );
  }
}
