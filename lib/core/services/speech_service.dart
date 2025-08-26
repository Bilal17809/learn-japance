import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../common/app_exceptions.dart';

class SpeechService extends GetxController {
  RxBool isListening = false.obs;
  RxString recognizedText = "".obs;
  RxString speechStatus = "".obs;
  TextEditingController controller = TextEditingController();
  late stt.SpeechToText speech;
  bool speechEnabled = false;

  @override
  void onInit() {
    super.onInit();
    _initSpeech();
  }

  @override
  void onClose() {
    controller.dispose();
    if (isListening.value) {
      stopListening();
    }
    super.onClose();
  }

  void _initSpeech() async {
    speech = stt.SpeechToText();
    speechEnabled = await speech.initialize(
      onError: (error) {
        isListening.value = false;
        speechStatus.value = "error";
      },
      onStatus: (status) {
        speechStatus.value = status;
        if (status == 'done' || status == 'notListening') {
          isListening.value = false;
        }
      },
    );
  }

  void startListeningWithDialog({String? locale}) async {
    if (!speechEnabled) {
      return;
    }
    if (isListening.value) {
      return;
    }
    isListening.value = true;
    recognizedText.value = "";
    speechStatus.value = "listening";

    await speech.listen(
      onResult: (result) {
        recognizedText.value = result.recognizedWords;
        controller.text = result.recognizedWords;

        if (result.finalResult) {
          isListening.value = false;
          speechStatus.value = "done";
        }
      },
      listenFor: const Duration(seconds: 30),
      pauseFor: const Duration(seconds: 3),
      localeId: locale,
      listenOptions: stt.SpeechListenOptions(
        partialResults: true,
        cancelOnError: false,
        listenMode: stt.ListenMode.dictation,
      ),
    );
  }

  void stopListening() async {
    if (speech.isListening) {
      await speech.stop();
    }
    isListening.value = false;
  }

  static const MethodChannel _methodChannel = MethodChannel('speech_channel');

  Future<void> startSpeechToText({String? locale}) async {
    try {
      isListening.value = true;
      final result = await _methodChannel.invokeMethod('getTextFromSpeech', {
        'languageISO': locale,
      });
      if (result != null && result.isNotEmpty) {
        controller.text = result;
        recognizedText.value = result;
      }
    } on PlatformException catch (e) {
      recognizedText.value = "${AppExceptions().failSpeech}: ${e.message}";
    } finally {
      isListening.value = false;
    }
  }

  void clearData() {
    controller.clear();
    recognizedText.value = "";
    speechStatus.value = "";
  }

  String getRecognizedText() {
    return recognizedText.value;
  }

  bool get isProcessing =>
      speechStatus.value == 'done' &&
      isListening.value == false &&
      recognizedText.value.isNotEmpty;
}
