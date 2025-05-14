String buildCustomPrompt({
  required String userInput,
  String? name,
  String? occupation,
  String? traits,
  String? extra,
}) {
  return '''
You are a chatbot with the following character:
- Name: ${name ?? "Unnamed"}
- Occupation: ${occupation ?? "Unknown"}
- Personality Traits: ${traits ?? "Neutral"}
- Additional Info: ${extra ?? "None"}

Your task is to respond to the user's input below in a way that reflects this personality.

User: "$userInput"
''';
}
