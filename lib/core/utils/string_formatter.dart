class StringFormatter {
  String cleanJsonOutput(String input) {
    final jsonRegex = RegExp(
      r'```(?:json)?\s*([\s\S]*?)\s*```',
      caseSensitive: false,
    );
    final match = jsonRegex.firstMatch(input);
    return match != null ? match.group(1)!.trim() : input.trim();
  }
}
