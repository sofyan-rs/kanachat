import 'package:fpdart/fpdart.dart';
import 'package:kanachat/core/error/failures.dart';
import 'package:kanachat/core/usecase/usecase.dart';
import 'package:kanachat/features/chat/domain/repository/chat_repository.dart';

class DeleteChatHistory implements UseCase<void, DeleteChatHistoryParams> {
  final ChatRepository chatRepository;

  DeleteChatHistory(this.chatRepository);

  @override
  Future<Either<Failure, void>> call(DeleteChatHistoryParams params) async {
    return await chatRepository.deleteChatHistory(
      chatHistoryId: params.chatHistoryId,
    );
  }
}

class DeleteChatHistoryParams {
  final String chatHistoryId;

  DeleteChatHistoryParams({required this.chatHistoryId});
}
