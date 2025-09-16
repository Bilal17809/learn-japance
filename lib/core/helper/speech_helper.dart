import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/common/app_exceptions.dart';
import '/core/common_widgets/common_widgets.dart';
import '/core/services/services.dart';
import '/core/utils/utils.dart';

class SpeechHelper {
  final SpeechService _speechService;

  SpeechHelper(this._speechService);

  Future<String?> getSpeechInput({required String? locale}) async {
    try {
      if (Platform.isAndroid) {
        await _speechService.startSpeechToText(locale: locale);
        return _speechService.getRecognizedText();
      } else {
        return await showDialog<String>(
          context: Get.context!,
          builder: (_) => const SpeechDialog(),
        );
      }
    } catch (e) {
      ToastUtil().showErrorToast('${AppExceptions().failToTranslate}: $e');
      return null;
    }
  }
}
