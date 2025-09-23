import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '/core/helper/helper.dart';
import '/core/common_widgets/common_widgets.dart';
import '/core/mixins/connectivity_mixin.dart';
import '/data/models/language_model.dart';
import 'services.dart';

class TtsService extends GetxController
    with WidgetsBindingObserver, ConnectivityMixin {
  final _audioService = Get.find<AudioService>();
  final RxString _currentSpeakingText = ''.obs;
  bool _cancelRequested = false;
  bool isSpeaking(String text) => _currentSpeakingText.value == text;
  double pitch = 1.0;
  double speed = 1.0;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    ever(_audioService.isPlaying, (playing) {
      if (playing == false) {
        _currentSpeakingText.value = '';
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      stop();
    }
  }

  String _buildTTSUrl(String text, String langCode) {
    final encoded = Uri.encodeComponent(text);
    return 'https://translate.google.com/translate_tts?ie=UTF-8'
        '&client=tw-ob'
        '&q=$encoded'
        '&tl=$langCode'
        '&ttsspeed=$speed'
        '&pitch=$pitch';
  }

  Future<void> speak(String text, LanguageModel? language) async {
    final completer = Completer<void>();
    initWithConnectivityCheck(
      context: Get.context!,
      onConnected: () async {
        if (text.isEmpty || language == null) {
          completer.complete();
          return;
        }
        _cancelRequested = false;
        _currentSpeakingText.value = text;
        final chunks =
            text.length > 200
                ? [
                  for (int i = 0; i < text.length; i += 200)
                    text.substring(
                      i,
                      i + 200 > text.length ? text.length : i + 200,
                    ),
                ]
                : [text];
        for (final chunk in chunks) {
          if (_cancelRequested) break;
          final url = _buildTTSUrl(chunk, language.code);
          if (language.code == 'zu') {
            SimpleToast.showCustomToast(
              context: Get.context!,
              message:
                  'Selected language is currently not supported for speech',
            );
            completer.complete();
            return;
          } else {
            await _audioService.playUrl(url);
            await TtsWaitHelper.waitUntilFalse(_audioService.isPlaying);
          }
        }
        completer.complete();
      },
    );
    return completer.future;
  }

  Future<void> stop() async {
    _cancelRequested = true;
    _currentSpeakingText.value = '';
    await _audioService.stop();
  }

  @override
  void onClose() {
    stop();
    super.onClose();
  }
}
