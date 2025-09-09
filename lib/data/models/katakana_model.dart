class KatakanaModel {
  final Katakana katakana;

  KatakanaModel({required this.katakana});

  factory KatakanaModel.fromJson(Map<String, dynamic> json) {
    return KatakanaModel(katakana: Katakana.fromJson(json['katakana']));
  }
}

class Katakana {
  final List<KatakanaItem> gojuon;
  final List<KatakanaItem> dakuten;
  final List<KatakanaItem> yoon;
  final List<KatakanaItem> loanwords;

  Katakana({
    required this.gojuon,
    required this.dakuten,
    required this.yoon,
    required this.loanwords,
  });

  factory Katakana.fromJson(Map<String, dynamic> json) {
    return Katakana(
      gojuon:
          (json['gojuon'] as List)
              .map((e) => KatakanaItem.fromJson(e))
              .toList(),
      dakuten:
          (json['dakuten'] as List)
              .map((e) => KatakanaItem.fromJson(e))
              .toList(),
      yoon:
          (json['yoon'] as List).map((e) => KatakanaItem.fromJson(e)).toList(),
      loanwords:
          (json['loanwords'] as List)
              .map((e) => KatakanaItem.fromJson(e))
              .toList(),
    );
  }
}

class KatakanaItem {
  final String katakana;
  final String romaji;

  KatakanaItem({required this.katakana, required this.romaji});

  factory KatakanaItem.fromJson(Map<String, dynamic> json) {
    return KatakanaItem(katakana: json['katakana'], romaji: json['romaji']);
  }
}
