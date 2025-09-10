import '/domain/repo/ai_repo.dart';
import '../data_source/ai_data_source.dart';

class AiRepoImpl implements AiRepo {
  final AiDataSource dataSource;

  AiRepoImpl(this.dataSource);

  @override
  Future<String> sendMessage(List<Map<String, String>> messages) {
    return dataSource.sendMessage(messages);
  }
}
