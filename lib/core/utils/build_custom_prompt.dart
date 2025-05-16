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
Use **Markdown formatting** where appropriate (bold, italic, lists, etc.).
**DO NOT** use triple backticks (\`\`\`) or any kind of code block around your answer.
Output your entire reply strictly in **raw JSON format** — **only the JSON object**, no extra commentary or formatting.

JSON structure to use:
{
  "title": "Short summary of the conversation (max 5 words)",
  "response": "Your character's response in Markdown format"
}

---

**User Input:**
"$userInput"

---

**Conversation History:**
$recentContext
''';
}
