class HiraganaModel {
  final Hiragana hiragana;

  HiraganaModel({required this.hiragana});

  factory HiraganaModel.fromJson(Map<String, dynamic> json) {
    return HiraganaModel(hiragana: Hiragana.fromJson(json['hiragana']));
  }
}

class Hiragana {
  final List<HiraganaItem> gojuon;
  final List<HiraganaItem> dakuten;
  final List<HiraganaItem> yoon;

  Hiragana({required this.gojuon, required this.dakuten, required this.yoon});

  factory Hiragana.fromJson(Map<String, dynamic> json) {
    return Hiragana(
      gojuon:
          (json['gojuon'] as List)
              .map((e) => HiraganaItem.fromJson(e))
              .toList(),
      dakuten:
          (json['dakuten'] as List)
              .map((e) => HiraganaItem.fromJson(e))
              .toList(),
      yoon:
          (json['yoon'] as List).map((e) => HiraganaItem.fromJson(e)).toList(),
    );
  }
}

class HiraganaItem {
  final String hiragana;
  final String romaji;

  HiraganaItem({required this.hiragana, required this.romaji});

  factory HiraganaItem.fromJson(Map<String, dynamic> json) {
    return HiraganaItem(hiragana: json['hiragana'], romaji: json['romaji']);
  }
}
