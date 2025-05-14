import 'package:fpdart/fpdart.dart';
import 'package:kanachat/core/error/failures.dart';
import 'package:kanachat/core/usecase/usecase.dart';
import 'package:kanachat/features/settings/domain/entities/chat_customization_entity.dart';
import 'package:kanachat/features/chat/domain/repository/chat_repository.dart';

class PostChat implements UseCase<String, PostChatParams> {
  final ChatRepository chatRepository;

  PostChat(this.chatRepository);

  @override
  Future<Either<Failure, String>> call(PostChatParams params) async {
    return await chatRepository.postChat(
      userInput: params.userInput,
      customization: params.customization,
    );
  }
}

class PostChatParams {
  final String userInput;
  final ChatCustomizationEntity customization;

  PostChatParams({required this.userInput, required this.customization});
}
