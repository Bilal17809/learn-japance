import 'dart:io';
import 'package:flutter/foundation.dart';
import '/core/common/app_exceptions.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class OnesignalService {
  static Future<void> init() async {
    if (Platform.isAndroid) {
      OneSignal.initialize('2a7f62b1-c940-4947-a18e-77c1fa40ff1b');
      await OneSignal.Notifications.requestPermission(true);
    } else if (Platform.isIOS) {
      OneSignal.initialize('');
      await OneSignal.Notifications.requestPermission(true);
    } else {
      debugPrint(AppExceptions().unsupportedPlatform);
    }
  }
}
