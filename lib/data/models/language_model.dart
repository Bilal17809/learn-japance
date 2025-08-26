import '/core/utils/utils.dart';

class LanguageModel {
  final String name;
  final String code;
  final String? flag;
  final String ttsCode;

  LanguageModel({
    required this.name,
    required this.code,
    this.flag,
    required this.ttsCode,
  });

  factory LanguageModel.fromJson(String name, String code, [String? flag]) {
    final ttsCode =
        (flag != null && flag.isNotEmpty)
            ? "${code.toLowerCase()}-${flag.toUpperCase()}"
            : code.toLowerCase();

    return LanguageModel(
      name: name,
      code: code.toLowerCase(),
      flag: flag,
      ttsCode: ttsCode,
    );
  }

  String get flagEmoji {
    if (flag != null && flag!.isNotEmpty) {
      return FlagUtil.countryCodeToEmoji(flag!);
    }
    return '🌐';
  }
}
