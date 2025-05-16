import 'package:fpdart/fpdart.dart';
import 'package:kanachat/core/error/failures.dart';
import 'package:kanachat/core/usecase/usecase.dart';
import 'package:kanachat/features/chat/domain/entities/chat_message_entity.dart';
import 'package:kanachat/features/chat/domain/repository/chat_repository.dart';

class StoreChat implements UseCase<ChatMessageEntity, StoreChatParams> {
  final ChatRepository chatRepository;

  StoreChat(this.chatRepository);

  @override
  Future<Either<Failure, ChatMessageEntity>> call(
    StoreChatParams params,
  ) async {
    return await chatRepository.storeChatMessage(
      chatMessage: params.chatMessage,
    );
  }
}

class StoreChatParams {
  final ChatMessageEntity chatMessage;

  StoreChatParams({required this.chatMessage});
}
