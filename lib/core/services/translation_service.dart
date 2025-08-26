import 'package:learn_japan/core/common/app_exceptions.dart';
import 'package:translator/translator.dart';

class TranslationService {
  final GoogleTranslator _translator = GoogleTranslator();

  Future<String> translateText(
    String text, {
    String targetLanguage = 'en',
  }) async {
    try {
      final translation = await _translator.translate(text, to: targetLanguage);
      return translation.text;
    } catch (e) {
      return "${AppExceptions().failToTranslate}: $e";
    }
  }

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
      return ["${AppExceptions().failToTranslate}: $e"];
    }
  }
}
