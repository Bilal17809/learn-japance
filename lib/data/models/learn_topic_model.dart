class LearnTopicModel {
  final String english;
  final String japanese;

  LearnTopicModel({required this.english, required this.japanese});

  factory LearnTopicModel.fromMap(Map<String, dynamic> map) {
    return LearnTopicModel(
      english: map['english'] as String,
      japanese: map['thumbnail'] as String,
    );
  }
}
