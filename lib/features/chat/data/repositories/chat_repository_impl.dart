import 'package:fpdart/fpdart.dart';
import 'package:kanachat/core/error/exceptions.dart';
import 'package:kanachat/core/error/failures.dart';
import 'package:kanachat/core/network/connection_checker.dart';
import 'package:kanachat/features/chat/data/datasources/local/chat_local_datasource.dart';
import 'package:kanachat/features/chat/data/datasources/remote/chat_remote_datasource.dart';
import 'package:kanachat/features/chat/data/models/chat_history_model.dart';
import 'package:kanachat/features/chat/data/models/chat_message_model.dart';
import 'package:kanachat/features/chat/domain/entities/chat_history_entity.dart';
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
    required List<ChatMessageEntity> chatHistory,
  }) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure("No Internet Connection"));
      }
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

  @override
  Future<Either<Failure, void>> clearChatHistoryList() async {
    try {
      await chatLocalDatasource.clearChatHistoryList();
      return const Right(null);
    } on LocalException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteChatHistory({
    required String chatHistoryId,
  }) async {
    try {
      await chatLocalDatasource.deleteChatHistory(chatHistoryId: chatHistoryId);
      return const Right(null);
    } on LocalException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<ChatHistoryEntity>>> getChatHistoryList() async {
    try {
      final response = await chatLocalDatasource.getChatHistoryList();
      return Right(response);
    } on LocalException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<ChatMessageEntity>>>
  getChatMessageListByChatHistoryId({required String chatHistoryId}) async {
    try {
      final response = await chatLocalDatasource
          .getChatMessageListByChatHistoryId(chatHistoryId: chatHistoryId);
      return Right(response);
    } on LocalException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, ChatHistoryEntity>> storeChatHistory({
    required ChatHistoryEntity chatHistory,
  }) async {
    try {
      final response = await chatLocalDatasource.storeChatHistory(
        chatHistory: ChatHistoryModel.fromEntity(chatHistory),
      );
      return Right(response);
    } on LocalException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, ChatHistoryEntity>> updateChatHistory({
    required String chatHistoryId,
    required String newTitle,
  }) async {
    try {
      final response = await chatLocalDatasource.updateChatHistory(
        chatHistoryId: chatHistoryId,
        newTitle: newTitle,
      );
      return Right(response);
    } on LocalException catch (e) {
      return left(Failure(e.message));
    }
  }
}
