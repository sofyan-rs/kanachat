import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanachat/core/usecase/usecase.dart';
import 'package:kanachat/features/settings/domain/entities/chat_customization_entity.dart';
import 'package:kanachat/features/settings/domain/usecases/get_customization_setting.dart';
import 'package:kanachat/features/settings/domain/usecases/reset_customization_setting.dart';
import 'package:kanachat/features/settings/domain/usecases/save_customization_setting.dart';

part 'chat_customization_event.dart';
part 'chat_customization_state.dart';

class ChatCustomizationBloc
    extends Bloc<ChatCustomizationEvent, ChatCustomizationState> {
  final GetCustomizationSetting getCustomizationSetting;
  final SaveCustomizationSetting saveCustomizationSetting;
  final ResetCustomizationSetting resetCustomizationSetting;

  ChatCustomizationBloc(
    this.getCustomizationSetting,
    this.saveCustomizationSetting,
    this.resetCustomizationSetting,
  ) : super(ChatCustomizationInitial()) {
    on<ChatCustomizationRequested>(
      (event, emit) => _onGetCustomization(event, emit),
    );
    on<ChatCustomizationUpdated>(
      (event, emit) => _onCustomizationSaved(event, emit),
    );
    on<ChatCustomizationReset>(
      (event, emit) => _onCustomizationReset(event, emit),
    );
  }

  void _onGetCustomization(
    ChatCustomizationRequested event,
    Emitter<ChatCustomizationState> emit,
  ) async {
    emit((ChatCustomizationLoading()));
    final res = await getCustomizationSetting(NoParams());
    res.fold(
      (l) => emit(ChatCustomizationError(message: l.message)),
      (r) => emit(ChatCustomizationLoaded(customization: r)),
    );
  }

  void _onCustomizationSaved(
    ChatCustomizationUpdated event,
    Emitter<ChatCustomizationState> emit,
  ) async {
    emit((ChatCustomizationLoading()));
    final res = await saveCustomizationSetting(
      SaveCustomizationSettingParams(customization: event.customization),
    );
    res.fold(
      (l) => emit(ChatCustomizationError(message: l.message)),
      (r) => _onGetCustomization(ChatCustomizationRequested(), emit),
    );
  }

  void _onCustomizationReset(
    ChatCustomizationReset event,
    Emitter<ChatCustomizationState> emit,
  ) async {
    emit((ChatCustomizationLoading()));
    final res = await resetCustomizationSetting(NoParams());
    res.fold(
      (l) => emit(ChatCustomizationError(message: l.message)),
      (r) => _onGetCustomization(ChatCustomizationRequested(), emit),
    );
  }
}
