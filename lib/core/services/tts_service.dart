import 'package:flutter/cupertino.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import '/data/models/language_model.dart';

class TtsService extends GetxController with WidgetsBindingObserver {
  final FlutterTts _flutterTts = FlutterTts();

  final RxString _currentSpeakingText = ''.obs;
  String get currentSpeakingText => _currentSpeakingText.value;

  bool isSpeaking(String text) => _currentSpeakingText.value == text;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    _flutterTts.setPitch(1);
    _flutterTts.setSpeechRate(0.5);

    _flutterTts.setCompletionHandler(() {
      _currentSpeakingText.value = '';
    });

    _flutterTts.setErrorHandler((msg) {
      _currentSpeakingText.value = '';
    });
  }

  Future<void> speak(String text, LanguageModel? language) async {
    if (text.isEmpty || language == null) return;

    _currentSpeakingText.value = text;
    await _flutterTts.setLanguage(language.ttsCode);
    final voices = await _flutterTts.getVoices;
    for (var voice in voices) {
      if (voice is Map && voice['locale'] == language.ttsCode) {
        final castedVoice = voice.map(
          (k, v) => MapEntry(k.toString(), v.toString()),
        );
        await _flutterTts.setVoice(castedVoice);
        break;
      }
    }

    await _flutterTts.speak(text);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      stop();
    }
  }

  Future<void> stop() async {
    _currentSpeakingText.value = '';
    await _flutterTts.stop();
  }

  @override
  void onClose() {
    _flutterTts.stop();
    super.onClose();
  }
}
