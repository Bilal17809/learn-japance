import 'package:flutter/material.dart';
import '/core/services/services.dart';
import '/core/theme/theme.dart';

class SpeechHelper {
  static IconData getMicrophoneIcon(SpeechService speechService) {
    final isListening = speechService.isListening.value;
    final status = speechService.speechStatus.value;
    final hasText = speechService.recognizedText.value.isNotEmpty;

    if (isListening) {
      return Icons.mic;
    } else if (status == 'done' && hasText) {
      return Icons.mic;
    } else if (status == 'error') {
      return Icons.error;
    } else {
      return Icons.mic_off;
    }
  }

  static void submitText(BuildContext context, SpeechService controller) {
    final text = controller.recognizedText.value.trim();
    if (controller.isListening.value) {
      controller.stopListening();
    }
    Navigator.of(context).pop(text);
  }

  static Color getMicrophoneColor(SpeechService controller) {
    final isListening = controller.isListening.value;
    final status = controller.speechStatus.value;
    final hasText = controller.recognizedText.value.isNotEmpty;

    if (isListening) {
      return AppColors.kSkyBlue;
    } else if (status == 'done' && hasText) {
      return AppColors.kSkyBlue;
    } else if (status == 'error') {
      return AppColors.kRed;
    } else {
      return AppColors.kGrey.withValues(alpha: 0.7);
    }
  }

  static String getStatusText(SpeechService controller) {
    final isListening = controller.isListening.value;
    final status = controller.speechStatus.value;
    final hasText = controller.recognizedText.value.isNotEmpty;

    if (isListening) {
      return 'Listening...';
    } else if (status == 'done' && hasText) {
      return 'Listened Successfully';
    } else if (status == 'error') {
      return 'Speech Recognition Error';
    } else {
      return 'Speech Recognition';
    }
  }

  static String getHintText(SpeechService controller) {
    final isListening = controller.isListening.value;
    final status = controller.speechStatus.value;
    final hasText = controller.recognizedText.value.isNotEmpty;

    if (isListening) {
      return 'Tap microphone to stop • Speak clearly';
    } else if (status == 'done' && hasText) {
      return 'Tap microphone to record again';
    } else if (status == 'error') {
      return 'Tap microphone to try again';
    } else {
      return 'Tap microphone to start recording';
    }
  }
}
