import 'package:fpdart/fpdart.dart';
import 'package:kanachat/core/error/failures.dart';
import 'package:kanachat/core/usecase/usecase.dart';
import 'package:kanachat/features/customization/domain/entities/chat_customization_entity.dart';
import 'package:kanachat/features/customization/domain/repository/chat_customization_repository.dart';

class GetCustomizationSetting
    implements UseCase<ChatCustomizationEntity, NoParams> {
  final ChatCustomizationRepository chatCustomizationRepository;

  GetCustomizationSetting(this.chatCustomizationRepository);

  @override
  Future<Either<Failure, ChatCustomizationEntity>> call(NoParams params) async {
    return await chatCustomizationRepository.getCustomizationSetting();
  }
}
