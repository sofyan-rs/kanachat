import 'package:fpdart/fpdart.dart';
import 'package:kanachat/core/error/failures.dart';
import 'package:kanachat/core/usecase/usecase.dart';
import 'package:kanachat/features/chat/domain/entities/chat_message_entity.dart';
import 'package:kanachat/features/chat/domain/repository/chat_repository.dart';

class GetChatListByHistoryId
    implements UseCase<List<ChatMessageEntity>, GetChatListByHistoryIdParams> {
  final ChatRepository chatRepository;

  GetChatListByHistoryId(this.chatRepository);

  @override
  Future<Either<Failure, List<ChatMessageEntity>>> call(
    GetChatListByHistoryIdParams params,
  ) async {
    return await chatRepository.getChatMessageListByChatHistoryId(
      chatHistoryId: params.chatHistoryId,
    );
  }
}

class GetChatListByHistoryIdParams {
  final String chatHistoryId;

  GetChatListByHistoryIdParams({required this.chatHistoryId});
}
