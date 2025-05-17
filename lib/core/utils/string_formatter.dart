class StringFormatter {
  String? extractTitle(String input) {
    final regex = RegExp(r'\[\^title:\s*(.*?)\^\]');
    final match = regex.firstMatch(input);
    return match?.group(1);
  }

  String extractResponseWithoutTitle(String input) {
    final regex = RegExp(r'\[\^title:\s*(.*?)\^\]');
    String cleaned = input.replaceFirst(regex, '').trim();
    return cleaned;
  }
}
