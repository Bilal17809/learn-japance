import 'dart:io';
import 'package:flutter/foundation.dart';
import '/core/common/app_exceptions.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class OnesignalService {
  static Future<void> init() async {
    if (Platform.isAndroid) {
      OneSignal.initialize('3264bcda-f704-44a1-b323-23cc4811dd4a');
      await OneSignal.Notifications.requestPermission(true);
    } else if (Platform.isIOS) {
      OneSignal.initialize('');
      await OneSignal.Notifications.requestPermission(true);
    } else {
      debugPrint(AppExceptions().unsupportedPlatform);
    }
  }
}
