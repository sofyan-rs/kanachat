import 'package:fpdart/fpdart.dart';
import 'package:kanachat/core/error/exceptions.dart';
import 'package:kanachat/core/error/failures.dart';
import 'package:kanachat/core/network/connection_checker.dart';
import 'package:kanachat/features/chat/data/datasources/remote/chat_remote_datasource.dart';
import 'package:kanachat/features/settings/domain/entities/chat_customization_entity.dart';
import 'package:kanachat/features/chat/domain/repository/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDatasource chatRemoteDatasource;
  final ConnectionChecker connectionChecker;

  const ChatRepositoryImpl({
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
      final response = await chatRemoteDatasource.postChat(
        userInput: userInput,
        customization: customization,
      );
      return Right(response);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
