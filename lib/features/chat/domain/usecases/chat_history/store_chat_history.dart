import 'package:fpdart/fpdart.dart';
import 'package:kanachat/core/error/failures.dart';
import 'package:kanachat/core/usecase/usecase.dart';
import 'package:kanachat/features/chat/domain/entities/chat_history_entity.dart';
import 'package:kanachat/features/chat/domain/repository/chat_repository.dart';

class StoreChatHistory
    implements UseCase<ChatHistoryEntity, StoreChatHistoryParams> {
  final ChatRepository chatRepository;

  StoreChatHistory(this.chatRepository);

  @override
  Future<Either<Failure, ChatHistoryEntity>> call(
    StoreChatHistoryParams params,
  ) async {
    return await chatRepository.storeChatHistory(
      chatHistory: params.chatHistory,
    );
  }
}

class StoreChatHistoryParams {
  final ChatHistoryEntity chatHistory;

  StoreChatHistoryParams({required this.chatHistory});
}
