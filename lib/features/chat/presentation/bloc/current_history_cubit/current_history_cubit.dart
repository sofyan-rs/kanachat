import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanachat/features/chat/domain/entities/chat_history_entity.dart';

final initChatHistory = ChatHistoryEntity(
  id: '',
  title: '',
  createdAt: DateTime.now(),
  modifiedAt: DateTime.now(),
);

class CurrentHistoryCubit extends Cubit<ChatHistoryEntity> {
  CurrentHistoryCubit() : super(initChatHistory);

  void setCurrentHistory(ChatHistoryEntity history) {
    emit(history);
  }

  void clearCurrentHistory() {
    emit(initChatHistory);
  }
}
