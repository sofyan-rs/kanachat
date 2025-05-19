extension ChatBotResponseExtension on String {
  String? get extractTitle {
    final regex = RegExp(r'\[\^title:\s*(.*?)\^\]');
    final match = regex.firstMatch(this);
    return match?.group(1);
  }

  String get extractResponseWithoutTitle {
    final regex = RegExp(r'\[\^title:\s*(.*?)\^\]');
    String cleaned = replaceFirst(regex, '').trim();
    return cleaned;
  }
}
