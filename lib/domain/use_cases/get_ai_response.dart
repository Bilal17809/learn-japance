import '/domain/repo/ai_repo.dart';

class GetAiResponse {
  final AiRepo aiRepo;
  GetAiResponse(this.aiRepo);

  Future<String> call(List<Map<String, String>> messages) {
    return aiRepo.sendMessage(messages);
  }
}
