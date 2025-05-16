part of 'chat_list_bloc.dart';

@immutable
sealed class ChatListState {}

final class ChatListInitial extends ChatListState {}

final class ChatListLoading extends ChatListState {}

final class ChatListLoaded extends ChatListState {
  final List<ChatMessageEntity> messages;

  ChatListLoaded({required this.messages});
}

final class ChatListError extends ChatListState {
  final String message;

  ChatListError({required this.message});
}

final class ChatListMessageSaved extends ChatListState {}

final class ChatListEmptied extends ChatListState {}
