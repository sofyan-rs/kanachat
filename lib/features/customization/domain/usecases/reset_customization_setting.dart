import 'package:fpdart/fpdart.dart';
import 'package:kanachat/core/error/failures.dart';
import 'package:kanachat/core/usecase/usecase.dart';
import 'package:kanachat/features/customization/domain/repository/chat_customization_repository.dart';

class ResetCustomizationSetting implements UseCase<void, NoParams> {
  final ChatCustomizationRepository chatCustomizationRepository;

  ResetCustomizationSetting(this.chatCustomizationRepository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await chatCustomizationRepository.resetCustomizationSetting();
  }
}
