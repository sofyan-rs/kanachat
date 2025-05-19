import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:kanachat/core/utils/build_custom_prompt.dart';
import 'package:kanachat/features/chat/domain/entities/chat_message_entity.dart';
import 'package:kanachat/features/customization/domain/entities/chat_customization_entity.dart';

abstract interface class ChatRemoteDatasource {
  Future<String> postChat({
    required String userInput,
    required ChatCustomizationEntity customization,
    required List<ChatMessageEntity> chatHistory,
  });
}

class ChatRemoteDatasourceImpl implements ChatRemoteDatasource {
  final GenerativeModel model;

  const ChatRemoteDatasourceImpl({required this.model});

  @override
  Future<String> postChat({
    required String userInput,
    required ChatCustomizationEntity customization,
    required List<ChatMessageEntity> chatHistory,
  }) async {
    try {
      final String prompt = buildCustomPrompt(
        userInput: userInput,
        name: customization.name,
        occupation: customization.occupation,
        traits: customization.traits,
        extra: customization.additionalInfo,
        recentMessages: chatHistory,
      );
      final chat = model.startChat(
        history:
            chatHistory
                .map(
                  (chat) => Content(chat.isUser ? 'user' : 'model', [
                    TextPart(chat.message),
                  ]),
                )
                .toList(),
        generationConfig: GenerationConfig(
          temperature: 0.7,
          maxOutputTokens: 512,
          topP: 0.9,
          topK: 40,
        ),
      );
      final response = await chat.sendMessage(Content.text(prompt));
      return response.text ?? '';
    } on VertexAISdkException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
