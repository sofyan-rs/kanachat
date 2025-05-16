import 'package:fpdart/fpdart.dart';
import 'package:kanachat/core/error/failures.dart';
import 'package:kanachat/core/usecase/usecase.dart';
import 'package:kanachat/features/chat/domain/entities/chat_history_entity.dart';
import 'package:kanachat/features/chat/domain/repository/chat_repository.dart';

class GetChatHistoryList implements UseCase<List<ChatHistoryEntity>, NoParams> {
  final ChatRepository chatRepository;

  GetChatHistoryList(this.chatRepository);

  @override
  Future<Either<Failure, List<ChatHistoryEntity>>> call(NoParams params) async {
    return await chatRepository.getChatHistoryList();
  }
}
