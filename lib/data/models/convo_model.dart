class ConvoModel {
  final String title;
  final String conversation;
  final String category;

  ConvoModel({
    required this.title,
    required this.conversation,
    required this.category,
  });

  factory ConvoModel.fromMap(Map<String, dynamic> map) {
    return ConvoModel(
      title: map['title'] as String,
      conversation: map['conversation'] as String,
      category: map['category'] as String,
    );
  }
}
