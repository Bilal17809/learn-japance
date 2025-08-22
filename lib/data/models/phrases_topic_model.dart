class PhrasesTopicModel {
  final int id;
  final String title;
  final String desc;
  final bool favorite;

  PhrasesTopicModel({
    required this.id,
    required this.title,
    required this.desc,
    required this.favorite,
  });

  factory PhrasesTopicModel.fromMap(Map<String, dynamic> map) {
    return PhrasesTopicModel(
      id: map['id'] as int,
      title: map['title'] as String,
      desc: map['desc'] as String,
      favorite: (map['favorite'] as int) == 1,
    );
  }
}
