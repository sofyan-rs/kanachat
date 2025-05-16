part of 'chat_history_bloc.dart';

@immutable
sealed class ChatHistoryEvent {}

final class ChatHistoryRequested extends ChatHistoryEvent {}

final class ChatHistoryStored extends ChatHistoryEvent {
  final ChatHistoryEntity chatHistory;

  ChatHistoryStored({required this.chatHistory});
}

final class ChatHistoryDeleted extends ChatHistoryEvent {
  final String chatHistoryId;

  ChatHistoryDeleted({required this.chatHistoryId});
}
