import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanachat/features/chat/domain/entities/chat_message_entity.dart';

class ChatMessagesCubit extends Cubit<List<ChatMessageEntity>> {
  ChatMessagesCubit() : super([]);

  void addMessage(ChatMessageEntity message) {
    final updatedMessages = List<ChatMessageEntity>.from(state);
    updatedMessages.add(message);
    emit(updatedMessages);
  }

  void setMessages(List<ChatMessageEntity> messages) {
    final updatedMessages = List<ChatMessageEntity>.from(messages);
    emit(updatedMessages);
  }

  void clearMessages() {
    emit([]);
  }
}
