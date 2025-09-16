class LearnModel {
  final int categoryId;
  final String english;
  final String japanese;

  LearnModel({
    required this.categoryId,
    required this.english,
    required this.japanese,
  });

  factory LearnModel.fromMap(Map<String, dynamic> map) {
    return LearnModel(
      categoryId: map['category_id'] as int,
      english: map['english'] as String,
      japanese: map['trans_n_male'] as String,
    );
  }
}
