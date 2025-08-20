class GrammarModel {
  final String id;
  final String title;
  final String category;
  final String description;
  final List<String> examples;

  GrammarModel({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.examples,
  });

  factory GrammarModel.fromJson(Map<String, dynamic> json) {
    return GrammarModel(
      id: json['id'] as String,
      title: json['タイトル'] as String,
      category: json['カテゴリー'] as String,
      description: json['説明'] as String,
      examples: List<String>.from(json['例文'] ?? []),
    );
  }
}
