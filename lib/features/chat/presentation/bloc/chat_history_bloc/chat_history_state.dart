part of 'chat_history_bloc.dart';

@immutable
sealed class ChatHistoryState {}

final class ChatHistoryInitial extends ChatHistoryState {}

final class ChatHistoryLoading extends ChatHistoryState {}

final class ChatHistoryListLoaded extends ChatHistoryState {
  final List<ChatHistoryEntity> chatHistoryList;

  ChatHistoryListLoaded({required this.chatHistoryList});
}

final class ChatHistorySaved extends ChatHistoryState {
  final ChatHistoryEntity message;

  ChatHistorySaved({required this.message});
}

final class ChatHistoryError extends ChatHistoryState {
  final String message;

  ChatHistoryError({required this.message});
}

final class ChatHistoryRemoved extends ChatHistoryState {}
