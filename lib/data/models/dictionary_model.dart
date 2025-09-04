class DictionaryModel {
  final String english;

  DictionaryModel({required this.english});

  factory DictionaryModel.fromMap(Map<String, dynamic> map) {
    return DictionaryModel(english: map['meaning'] as String);
  }
}
