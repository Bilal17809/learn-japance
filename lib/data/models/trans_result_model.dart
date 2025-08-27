class TransResultModel {
  final String id;
  final String input;
  final String output;
  final bool isSourceRtl;
  final bool isTargetRtl;

  TransResultModel({
    required this.id,
    required this.input,
    required this.output,
    this.isSourceRtl = false,
    this.isTargetRtl = false,
  });
}
