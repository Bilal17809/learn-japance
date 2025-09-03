class LearnModel {
  final int catId;
  final String english;
  final String japanese;

  LearnModel({
    required this.catId,
    required this.english,
    required this.japanese,
  });

  factory LearnModel.fromMap(Map<String, dynamic> map) {
    return LearnModel(
      catId: map['category_id'] as int,
      english: map['english'] as String,
      japanese: map['trans_n_male'] as String,
    );
  }
}
