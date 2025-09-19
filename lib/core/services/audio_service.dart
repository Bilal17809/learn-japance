import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/foundation.dart';

class AudioService extends GetxService {
  final _player = AudioPlayer();

  final RxBool isPlaying = false.obs;

  @override
  void onInit() {
    super.onInit();
    _player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        isPlaying.value = false;
      } else {
        isPlaying.value = state.playing;
      }
    });
  }

  Future<void> playUrl(String url) async {
    try {
      await _player.setUrl(url);
      await _player.play();
    } catch (e) {
      debugPrint("AudioService Error: $e");
    }
  }

  Future<void> stop() async {
    await _player.stop();
  }

  @override
  void onClose() {
    _player.dispose();
    super.onClose();
  }
}
