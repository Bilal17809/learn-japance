import '/core/local_storage/local_storage.dart';
import '/data/models/models.dart';

class TranslatorStorageService {
  final LocalStorage _localStorage;

  TranslatorStorageService({required LocalStorage localStorage})
    : _localStorage = localStorage;

  // Language preferences
  Future<String?> getSourceLanguage() async {
    return await _localStorage.getString('sourceLanguage');
  }

  Future<void> setSourceLanguage(String languageName) async {
    await _localStorage.setString('sourceLanguage', languageName);
  }

  Future<String?> getTargetLanguage() async {
    return await _localStorage.getString('targetLanguage');
  }

  Future<void> setTargetLanguage(String languageName) async {
    await _localStorage.setString('targetLanguage', languageName);
  }

  // Translation history
  Future<List<TranslationResultModel>> getTranslations() async {
    final saved = await _localStorage.getStringList('translations');
    if (saved == null) return [];

    return saved.map((s) {
      final parts = s.split('|');
      return TranslationResultModel(
        id: parts[0],
        input: parts[1],
        output: parts[2],
        isSourceRtl: parts[3] == 'true',
        isTargetRtl: parts[4] == 'true',
      );
    }).toList();
  }

  Future<void> saveTranslation(TranslationResultModel translation) async {
    final saved = await _localStorage.getStringList('translations') ?? [];
    saved.add(
      '${translation.id}|${translation.input}|${translation.output}|${translation.isSourceRtl}|${translation.isTargetRtl}',
    );
    await _localStorage.setStringList('translations', saved);
  }

  Future<void> removeTranslation(String id) async {
    final saved = await _localStorage.getStringList('translations') ?? [];
    saved.removeWhere((s) => s.split('|')[0] == id);
    await _localStorage.setStringList('translations', saved);
  }

  // Favorites
  Future<List<TranslationResultModel>> getFavorites() async {
    final saved = await _localStorage.getStringList('favorites');
    if (saved == null) return [];

    return saved.map((s) {
      final parts = s.split('|');
      return TranslationResultModel(
        id: parts[0],
        input: parts[1],
        output: parts[2],
        isSourceRtl: parts[3] == 'true',
        isTargetRtl: parts[4] == 'true',
      );
    }).toList();
  }

  Future<void> saveFavorites(List<TranslationResultModel> favorites) async {
    await _localStorage.setStringList(
      'favorites',
      favorites
          .map(
            (f) =>
                '${f.id}|${f.input}|${f.output}|${f.isSourceRtl}|${f.isTargetRtl}',
          )
          .toList(),
    );
  }

  // Clear methods
  Future<void> clearTranslations() async {
    await _localStorage.remove('translations');
  }

  Future<void> clearFavorites() async {
    await _localStorage.remove('favorites');
  }

  Future<void> clearLanguagePreferences() async {
    await _localStorage.remove('sourceLanguage');
    await _localStorage.remove('targetLanguage');
  }

  Future<void> clearAll() async {
    await clearTranslations();
    await clearFavorites();
    await clearLanguagePreferences();
  }
}
