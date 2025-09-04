class ConvoModel {
  final String cat;
  final String catTrans;
  final String convo;
  final String convoTrans;
  final String title;
  final String titleTrans;

  ConvoModel({
    required this.cat,
    required this.catTrans,
    required this.convo,
    required this.convoTrans,
    required this.title,
    required this.titleTrans,
  });

  factory ConvoModel.fromJson(Map<String, dynamic> json) {
    return ConvoModel(
      cat: json['category'],
      catTrans: json['category_translation'],
      convo: json['conversation'],
      convoTrans: json['conversation_translation'],
      title: json['title'],
      titleTrans: json['title_translation'],
    );
  }
}
