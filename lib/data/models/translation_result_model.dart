class TranslationResultModel {
  final String id;
  final String input;
  final String output;
  final bool isSourceRtl;
  final bool isTargetRtl;
  final String targetLangCode;

  TranslationResultModel({
    required this.id,
    required this.input,
    required this.output,
    this.isSourceRtl = false,
    this.isTargetRtl = false,
    required this.targetLangCode,
  });
}
