import 'package:fpdart/fpdart.dart';
import 'package:kanachat/core/error/failures.dart';
import 'package:kanachat/features/chat/domain/entities/chat_message_entity.dart';
import 'package:kanachat/features/customization/domain/entities/chat_customization_entity.dart';

abstract class ChatRepository {
  Future<Either<Failure, String>> postChat({
    required String userInput,
    required ChatCustomizationEntity customization,
  });
  Future<Either<Failure, List<ChatMessageEntity>>> getChatMessageList();
  Future<Either<Failure, ChatMessageEntity>> storeChatMessage({
    required ChatMessageEntity chatMessage,
  });
  Future<Either<Failure, void>> clearChatMessageList();
}
