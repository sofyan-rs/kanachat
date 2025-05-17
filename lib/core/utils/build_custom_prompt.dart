import 'package:flutter/foundation.dart';
import 'package:kanachat/features/chat/domain/entities/chat_message_entity.dart';

String buildCustomPrompt({
  required String userInput,
  String? name,
  String? occupation,
  String? traits,
  String? extra,
  List<ChatMessageEntity>? recentMessages,
}) {
  final buffer = StringBuffer();
  final detailsBuffer = StringBuffer();

  if (name?.trim().isNotEmpty == true) {
    detailsBuffer.writeln('**Name:** ${name!.trim()}');
  }
  if (occupation?.trim().isNotEmpty == true) {
    detailsBuffer.writeln('**Occupation:** ${occupation!.trim()}');
  }
  if (traits?.trim().isNotEmpty == true) {
    detailsBuffer.writeln('**Personality Traits:** ${traits!.trim()}');
  }
  if (extra?.trim().isNotEmpty == true) {
    detailsBuffer.writeln('**Additional Info:** ${extra!.trim()}');
  }

  if (detailsBuffer.isNotEmpty) {
    buffer.writeln(
      "You are a chatbot roleplaying a character with the following details:",
    );
    buffer.writeln(detailsBuffer.toString());
    buffer.writeln();
  }

  buffer.writeln('---\n');
  buffer.writeln('**Instructions:**');
  buffer.writeln(
    'Respond to the user\'s input **in character**, reflecting the personality, occupation, and any additional context. Use **Markdown formatting** where appropriate (bold, italic, lists, etc.).',
  );
  buffer.writeln('Also, provide a title for your response in format :');
  buffer.writeln('[^title: {title}^]');
  buffer.writeln('---\n');

  buffer.writeln('**User Input:**');
  buffer.writeln('"$userInput"\n');

  final recentContext =
      (recentMessages != null && recentMessages.isNotEmpty)
          ? recentMessages
              .take(5)
              .map((msg) => '- ${msg.isUser ? 'user' : 'bot'}: ${msg.message}')
              .join('\n')
          : null;

  if (recentContext != null) {
    buffer.writeln('**Conversation History:**');
    buffer.writeln(recentContext);
  }

  if (kDebugMode) {
    print('Custom Prompt: ${buffer.toString()}');
  }

  return buffer.toString();
}
