import 'package:fpdart/fpdart.dart';
import 'package:kanachat/core/error/failures.dart';
import 'package:kanachat/features/customization/domain/entities/chat_customization_entity.dart';

abstract class ChatRepository {
  Future<Either<Failure, String>> postChat({
    required String userInput,
    required ChatCustomizationEntity customization,
  });
}
