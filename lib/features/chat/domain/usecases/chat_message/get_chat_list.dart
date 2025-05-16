import 'package:fpdart/fpdart.dart';
import 'package:kanachat/core/error/failures.dart';
import 'package:kanachat/core/usecase/usecase.dart';
import 'package:kanachat/features/chat/domain/entities/chat_message_entity.dart';
import 'package:kanachat/features/chat/domain/repository/chat_repository.dart';

class GetChatList implements UseCase<List<ChatMessageEntity>, NoParams> {
  final ChatRepository chatRepository;

  GetChatList(this.chatRepository);

  @override
  Future<Either<Failure, List<ChatMessageEntity>>> call(NoParams params) async {
    return await chatRepository.getChatMessageList();
  }
}
