import 'package:fpdart/fpdart.dart';
import 'package:kanachat/core/error/failures.dart';
import 'package:kanachat/core/usecase/usecase.dart';
import 'package:kanachat/features/chat/domain/entities/chat_history_entity.dart';
import 'package:kanachat/features/chat/domain/repository/chat_repository.dart';

class UpdateChatHistory
    implements UseCase<ChatHistoryEntity, UpdateChatHistoryParams> {
  final ChatRepository chatRepository;

  UpdateChatHistory(this.chatRepository);

  @override
  Future<Either<Failure, ChatHistoryEntity>> call(
    UpdateChatHistoryParams params,
  ) async {
    return await chatRepository.updateChatHistory(
      chatHistoryId: params.id,
      newTitle: params.newTitle,
    );
  }
}

class UpdateChatHistoryParams {
  final String id;
  final String newTitle;

  UpdateChatHistoryParams({required this.id, required this.newTitle});
}
