import '/core/utils/utils.dart';

class LanguageModel {
  final String name;
  final String code;
  final String? flag;

  LanguageModel({required this.name, required this.code, this.flag});

  factory LanguageModel.fromJson(String name, String code, [String? flag]) {
    return LanguageModel(name: name, code: code, flag: flag);
  }
  String get flagEmoji {
    if (flag != null && flag!.isNotEmpty) {
      return FlagUtil.countryCodeToEmoji(flag!);
    }
    return '🌐';
  }
}
