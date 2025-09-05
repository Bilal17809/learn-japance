class ConversationModel {
  final String category;
  final String categoryTranslation;
  final String conversation;
  final String conversationTranslation;
  final String title;
  final String titleTrans;

  ConversationModel({
    required this.category,
    required this.categoryTranslation,
    required this.conversation,
    required this.conversationTranslation,
    required this.title,
    required this.titleTrans,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      category: json['category'],
      categoryTranslation: json['category_translation'],
      conversation: json['conversation'],
      conversationTranslation: json['conversation_translation'],
      title: json['title'],
      titleTrans: json['title_translation'],
    );
  }
}
