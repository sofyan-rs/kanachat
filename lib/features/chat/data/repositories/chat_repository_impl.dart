import 'package:fpdart/fpdart.dart';
import 'package:kanachat/core/error/exceptions.dart';
import 'package:kanachat/core/error/failures.dart';
import 'package:kanachat/core/network/connection_checker.dart';
import 'package:kanachat/features/chat/data/datasources/local/chat_local_datasource.dart';
import 'package:kanachat/features/chat/data/datasources/remote/chat_remote_datasource.dart';
import 'package:kanachat/features/chat/data/models/chat_message_model.dart';
import 'package:kanachat/features/chat/domain/entities/chat_message_entity.dart';
import 'package:kanachat/features/customization/domain/entities/chat_customization_entity.dart';
import 'package:kanachat/features/chat/domain/repository/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatLocalDatasource chatLocalDatasource;
  final ChatRemoteDatasource chatRemoteDatasource;
  final ConnectionChecker connectionChecker;

  const ChatRepositoryImpl({
    required this.chatLocalDatasource,
    required this.chatRemoteDatasource,
    required this.connectionChecker,
  });

  @override
  Future<Either<Failure, String>> postChat({
    required String userInput,
    required ChatCustomizationEntity customization,
  }) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure("No Internet Connection"));
      }
      final chatHistory = await chatLocalDatasource.getChatMessageList();
      final response = await chatRemoteDatasource.postChat(
        userInput: userInput,
        customization: customization,
        chatHistory: chatHistory,
      );
      return Right(response);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<ChatMessageEntity>>> getChatMessageList() async {
    try {
      final response = await chatLocalDatasource.getChatMessageList();
      return Right(response);
    } on LocalException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, ChatMessageEntity>> storeChatMessage({
    required ChatMessageEntity chatMessage,
  }) async {
    try {
      final response = await chatLocalDatasource.storeChatMessage(
        chatMessage: ChatMessageModel.fromEntity(chatMessage),
      );
      return Right(response);
    } on LocalException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> clearChatMessageList() async {
    try {
      await chatLocalDatasource.clearChatMessageList();
      return const Right(null);
    } on LocalException catch (e) {
      return left(Failure(e.message));
    }
  }
}
