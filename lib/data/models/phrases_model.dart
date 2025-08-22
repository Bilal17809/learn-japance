class PhrasesModel {
  final int id;
  final int topicId;
  final String explanation;
  final String sentence;

  PhrasesModel({
    required this.id,
    required this.topicId,
    required this.explanation,
    required this.sentence,
  });

  factory PhrasesModel.fromMap(Map<String, dynamic> map) {
    return PhrasesModel(
      id: map['id'] as int,
      topicId: map['TopicId'] as int,
      explanation: map['explaination'] as String,
      sentence: map['sentence'] as String,
    );
  }
}
