import 'dart:async';
import 'package:get/get.dart';

class TtsWaitHelper {
  static Future<void> waitUntilFalse(RxBool observable) async {
    if (observable.isFalse) return;
    final completer = Completer<void>();
    late Worker worker;
    worker = ever<bool>(observable, (playing) {
      if (!playing) {
        worker.dispose();
        completer.complete();
      }
    });
    return completer.future;
  }
}
