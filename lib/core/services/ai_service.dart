import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:learn_japan/core/config/client.dart';
import 'package:learn_japan/core/config/environment.dart';

class AiService {
  Future<String> sendMessage(List<Map<String, String>> messages) async {
    try {
      final formattedMessages =
          messages.map((message) {
            return {
              "role": message["role"] ?? "user",
              "content": message["content"] ?? "",
            };
          }).toList();

      final response = await http.post(
        Uri.parse(EnvironmentConfig.baseUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $mistralKey",
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
        return "Error: ${response.statusCode} ${response.body}";
      }
    } catch (e) {
      return "Error generating content: $e";
    }
  }
}
