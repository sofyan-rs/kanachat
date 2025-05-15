import 'package:kanachat/core/secrets/app_secrets.dart';

class ApiEndpoints {
  // Base URL
  static const String baseUrl = "https://generativelanguage.googleapis.com";

  // Endpoints
  static String generateContent =
      "/v1beta/models/gemini-2.0-flash:generateContent?key=${AppSecrets.geminiApiKey}";
}
