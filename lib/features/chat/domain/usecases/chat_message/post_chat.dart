import 'package:fpdart/fpdart.dart';
import 'package:kanachat/core/error/failures.dart';
import 'package:kanachat/core/usecase/usecase.dart';
import 'package:kanachat/features/chat/domain/entities/chat_message_entity.dart';
import 'package:kanachat/features/customization/domain/entities/chat_customization_entity.dart';
import 'package:kanachat/features/chat/domain/repository/chat_repository.dart';

class PostChat implements UseCase<String, PostChatParams> {
  final ChatRepository chatRepository;

  PostChat(this.chatRepository);

  @override
  Future<Either<Failure, String>> call(PostChatParams params) async {
    return await chatRepository.postChat(
      userInput: params.userInput,
      customization: params.customization,
      chatHistory: params.chatHistory,
    );
  }
}

class PostChatParams {
  final String userInput;
  final ChatCustomizationEntity customization;
  final List<ChatMessageEntity> chatHistory;

  PostChatParams({
    required this.userInput,
    required this.customization,
    required this.chatHistory,
  });
}
