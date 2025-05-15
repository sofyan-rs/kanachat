import 'package:kanachat/features/chat/domain/entities/chat_message_entity.dart';

String buildCustomPrompt({
  required String userInput,
  String? name,
  String? occupation,
  String? traits,
  String? extra,
  List<ChatMessageEntity>? recentMessages,
}) {
  final characterName = name ?? "Unnamed";
  final characterOccupation = occupation ?? "Unknown";
  final characterTraits = traits ?? "Neutral";
  final additionalInfo = extra ?? "None";
  final recentContext =
      (recentMessages != null && recentMessages.isNotEmpty)
          ? recentMessages
              .take(5)
              .map((msg) => '- ${msg.isUser ? 'user' : 'bot'}: ${msg.message}')
              .join('\n')
          : "No recent messages.";

  return '''
You are a chatbot roleplaying a character with the following details:

**Name:** $characterName
**Occupation:** $characterOccupation
**Personality Traits:** $characterTraits
**Additional Info:** $additionalInfo

---

**Instructions:**
Respond to the user's input **in character**, reflecting the personality, occupation, and any additional context.
Use **Markdown formatting** if necessary (bold, italic, lists, etc.).

---

**User Input:**
"$userInput"

---

**Conversation History:**
$recentContext
''';
}
