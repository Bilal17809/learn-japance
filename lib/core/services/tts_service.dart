import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
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
    initWithConnectivityCheck(
      context: Get.context!,
      onConnected: () async {
        if (text.isEmpty || language == null) return;
        _cancelRequested = false;
        _currentSpeakingText.value = text;
        final List<String> chunks = [];
        if (text.length > 200) {
          int start = 0;
          while (start < text.length) {
            int end = (start + 200 < text.length) ? start + 200 : text.length;
            chunks.add(text.substring(start, end));
            start = end;
          }
        } else {
          chunks.add(text);
        }
        for (final chunk in chunks) {
          if (_cancelRequested) break;
          final url = _buildTTSUrl(chunk, language.code);
          if (language.code == 'zu') {
            return SimpleToast.showCustomToast(
              context: Get.context!,
              message:
                  'Selected language is currently not supported for speech',
            );
          } else {
            await _audioService.playUrl(url);
          }
        }
      },
    );
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
