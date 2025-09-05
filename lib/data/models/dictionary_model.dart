class DictionaryModel {
  final String english;
  final String japanese;

  DictionaryModel({required this.english, required this.japanese});

  factory DictionaryModel.fromMap(Map<String, dynamic> map) {
    return DictionaryModel(
      english: map['english'] as String,
      japanese: map['japanese'] as String,
    );
  }
}
