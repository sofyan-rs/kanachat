import 'package:dio/dio.dart';
import 'package:kanachat/core/api/api_client.dart';
import 'package:kanachat/core/api/api_constants.dart';
import 'package:kanachat/core/error/exceptions.dart';
import 'package:kanachat/core/utils/build_custom_prompt.dart';
import 'package:kanachat/features/customization/domain/entities/chat_customization_entity.dart';

abstract interface class ChatRemoteDatasource {
  Future<String> postChat({
    required String userInput,
    required ChatCustomizationEntity customization,
  });
}

class ChatRemoteDatasourceImpl implements ChatRemoteDatasource {
  final ApiClient apiClient;

  const ChatRemoteDatasourceImpl({required this.apiClient});

  @override
  Future<String> postChat({
    required String userInput,
    required ChatCustomizationEntity customization,
  }) async {
    try {
      final String prompt = buildCustomPrompt(
        userInput: userInput,
        name: customization.name,
        occupation: customization.occupation,
        traits: customization.traits,
        extra: customization.additionalInfo,
      );

      final response = await apiClient.dio.post(
        ApiEndpoints.generateContent,
        data: {
          "contents": [
            {
              "parts": [
                {"text": prompt},
              ],
            },
          ],
        },
      );
      final data = response.data;
      final reply = data['candidates'][0]['content']['parts'][0]['text'];
      return reply;
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data['message'] ?? "Something went wrong",
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
