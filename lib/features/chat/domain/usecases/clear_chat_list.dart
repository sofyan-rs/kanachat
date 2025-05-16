import 'package:fpdart/fpdart.dart';
import 'package:kanachat/core/error/failures.dart';
import 'package:kanachat/core/usecase/usecase.dart';
import 'package:kanachat/features/chat/domain/repository/chat_repository.dart';

class ClearChatList implements UseCase<void, NoParams> {
  final ChatRepository chatRepository;

  ClearChatList(this.chatRepository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await chatRepository.clearChatMessageList();
  }
}
