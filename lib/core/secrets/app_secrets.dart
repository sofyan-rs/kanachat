import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppSecrets {
  static final String geminiApiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
}
