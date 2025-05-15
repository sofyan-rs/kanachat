import 'package:fpdart/fpdart.dart';
import 'package:kanachat/core/error/exceptions.dart';
import 'package:kanachat/core/error/failures.dart';
import 'package:kanachat/features/customization/data/datasources/local/chat_customization_local_datasource.dart';
import 'package:kanachat/features/customization/data/models/chat_customization_model.dart';
import 'package:kanachat/features/customization/domain/entities/chat_customization_entity.dart';
import 'package:kanachat/features/customization/domain/repository/chat_customization_repository.dart';

class ChatCustomizationRepositoryImpl implements ChatCustomizationRepository {
  final ChatCustomizationLocalDatasource localDatasource;

  const ChatCustomizationRepositoryImpl({required this.localDatasource});

  @override
  Future<Either<Failure, ChatCustomizationEntity>>
  getCustomizationSetting() async {
    try {
      final customization = await localDatasource.getCustomizationSetting();
      return Right(customization);
    } on LocalException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> resetCustomizationSetting() async {
    try {
      await localDatasource.resetCustomizationSetting();
      return const Right(null);
    } on LocalException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> saveCustomizationSetting({
    required ChatCustomizationEntity customization,
  }) async {
    try {
      await localDatasource.saveCustomizationSetting(
        customization: ChatCustomizationModel.fromEntity(customization),
      );
      return const Right(null);
    } on LocalException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
