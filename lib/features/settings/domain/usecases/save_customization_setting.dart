import 'package:fpdart/fpdart.dart';
import 'package:kanachat/core/error/failures.dart';
import 'package:kanachat/core/usecase/usecase.dart';
import 'package:kanachat/features/settings/domain/entities/chat_customization_entity.dart';
import 'package:kanachat/features/settings/domain/repository/chat_customization_repository.dart';

class SaveCustomizationSetting
    implements UseCase<void, SaveCustomizationSettingParams> {
  final ChatCustomizationRepository chatCustomizationRepository;

  SaveCustomizationSetting(this.chatCustomizationRepository);

  @override
  Future<Either<Failure, void>> call(
    SaveCustomizationSettingParams params,
  ) async {
    return await chatCustomizationRepository.saveCustomizationSetting(
      customization: params.customization,
    );
  }
}

class SaveCustomizationSettingParams {
  final ChatCustomizationEntity customization;

  SaveCustomizationSettingParams({required this.customization});
}
