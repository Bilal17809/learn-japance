import 'dart:convert';
import 'package:http/http.dart' as http;
import '/core/config/environment.dart';
import '/core/common/app_exceptions.dart';

class AiDataSource {
  final String apiKey;
  AiDataSource(this.apiKey);

  Future<String> sendMessage(List<Map<String, String>> messages) async {
    try {
      final formattedMessages =
          messages.map((message) {
            return {
              "role": message["role"] ?? "user",
              "content": message["content"] ?? "",
            };
          }).toList();

      final uri = Uri.parse(EnvironmentConfig.baseUrl);
      final response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $apiKey",
        },
        body: jsonEncode({
          "model": "mistral-small",
          "messages": formattedMessages,
          "temperature": 0.7,
          "max_tokens": 200,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final content = data["choices"][0]["message"]["content"];
        return content ?? "No response generated";
      } else {
        throw Exception(
          '${AppExceptions().failedApiCall}: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error generating content: $e');
    }
  }
}
