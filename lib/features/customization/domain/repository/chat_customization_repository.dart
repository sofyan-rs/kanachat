import 'package:fpdart/fpdart.dart';
import 'package:kanachat/core/error/failures.dart';
import 'package:kanachat/features/customization/domain/entities/chat_customization_entity.dart';

abstract class ChatCustomizationRepository {
  Future<Either<Failure, ChatCustomizationEntity>> getCustomizationSetting();
  Future<Either<Failure, void>> saveCustomizationSetting({
    required ChatCustomizationEntity customization,
  });
  Future<Either<Failure, void>> resetCustomizationSetting();
}
