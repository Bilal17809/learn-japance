import 'package:translator/translator.dart';

class TranslationService {
  final GoogleTranslator _translator = GoogleTranslator();

  /// Translates given [text] to the [targetLanguage] (default: English 'en').
  Future<String> translateText(
    String text, {
    String targetLanguage = 'en',
  }) async {
    try {
      final translation = await _translator.translate(text, to: targetLanguage);
      return translation.text;
    } catch (e) {
      return "Translation failed: $e";
    }
  }

  /// Translates a list of texts at once (batch processing).
  Future<List<String>> translateList(
    List<String> texts, {
    String targetLanguage = 'en',
  }) async {
    try {
      final translations = await Future.wait(
        texts.map((t) => _translator.translate(t, to: targetLanguage)),
      );
      return translations.map((t) => t.text).toList();
    } catch (e) {
      return ["Translation failed: $e"];
    }
  }
}
