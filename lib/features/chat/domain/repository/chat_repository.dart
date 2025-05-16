import 'package:fpdart/fpdart.dart';
import 'package:kanachat/core/error/failures.dart';
import 'package:kanachat/features/chat/domain/entities/chat_history_entity.dart';
import 'package:kanachat/features/chat/domain/entities/chat_message_entity.dart';
import 'package:kanachat/features/customization/domain/entities/chat_customization_entity.dart';

abstract class ChatRepository {
  // Chat Message
  Future<Either<Failure, String>> postChat({
    required String userInput,
    required ChatCustomizationEntity customization,
    required List<ChatMessageEntity> chatHistory,
  });
  Future<Either<Failure, List<ChatMessageEntity>>> getChatMessageList();
  Future<Either<Failure, ChatMessageEntity>> storeChatMessage({
    required ChatMessageEntity chatMessage,
  });
  Future<Either<Failure, void>> clearChatMessageList();

  // Chat History
  Future<Either<Failure, List<ChatMessageEntity>>>
  getChatMessageListByChatHistoryId({required String chatHistoryId});
  Future<Either<Failure, void>> deleteChatHistory({
    required String chatHistoryId,
  });
  Future<Either<Failure, List<ChatHistoryEntity>>> getChatHistoryList();
  Future<Either<Failure, ChatHistoryEntity>> storeChatHistory({
    required ChatHistoryEntity chatHistory,
  });
  Future<Either<Failure, void>> clearChatHistoryList();
}
