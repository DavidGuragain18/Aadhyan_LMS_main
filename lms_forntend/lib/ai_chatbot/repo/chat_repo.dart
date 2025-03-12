
import 'package:dio/dio.dart';
import 'package:learn_management_system/ai_chatbot/constant.dart';
import 'package:learn_management_system/ai_chatbot/models/chat_message_models.dart';

class ChatRepo {
  static Future<String> chatTextGenerationRepo(
      List<ChatMessageModel> previousMessage) async {
    try {
      Dio dio = Dio();
      final response = await dio.post(
          "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=${API_KEY}",
          data: {
            "contents": previousMessage.map((e) => e.toMap()).toList(),
            "generationConfig": {
              "temperature": 1,
              "topK": 64,
              "topP": 0.95,
              "maxOutputTokens": 8192,
              "stopSequences": []
            },
            "safetySettings": [
              {
                "category": "HARM_CATEGORY_HARASSMENT",
              },
              {
                "category": "HARM_CATEGORY_HATE_SPEECH",
                "threshold": "BLOCK_MEDIUM_AND_ABOVE"
              },
              {
                "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
                "threshold": "BLOCK_MEDIUM_AND_ABOVE"
              },
              {
                "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
                "threshold": "BLOCK_MEDIUM_AND_ABOVE"
              }
            ]
          });
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return response
            .data['candidates'].first['content']['parts'].first['text'];
      }
      print(response);
      // return '';
    } catch (e) {
      print(e.toString());
    }
    return '';
  }
}
