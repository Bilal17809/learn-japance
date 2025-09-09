class KanjiModel {
  final String kanji;
  final int grade;
  final int? strokeCount;
  final List<String> meanings;
  final List<String> onReadings;
  final List<String> kunReadings;
  final int? jlpt;

  KanjiModel({
    required this.kanji,
    required this.grade,
    this.strokeCount,
    required this.meanings,
    required this.onReadings,
    required this.kunReadings,
    this.jlpt,
  });

  factory KanjiModel.fromJson(Map<String, dynamic> json) {
    return KanjiModel(
      kanji: json['kanji'],
      grade: json['grade'],
      strokeCount: json['stroke_count'],
      meanings: List<String>.from(json['meanings'] ?? []),
      onReadings: List<String>.from(json['on_readings'] ?? []),
      kunReadings: List<String>.from(json['kun_readings'] ?? []),
      jlpt: json['jlpt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'kanji': kanji,
      'grade': grade,
      'stroke_count': strokeCount,
      'meanings': meanings,
      'on_readings': onReadings,
      'kun_readings': kunReadings,
      'jlpt': jlpt,
    };
  }
}
