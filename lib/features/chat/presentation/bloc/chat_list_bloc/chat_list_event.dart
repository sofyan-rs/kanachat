part of 'chat_list_bloc.dart';

@immutable
sealed class ChatListEvent {}

final class ChatListRequested extends ChatListEvent {}

final class ChatListMessageAdded extends ChatListEvent {
  final ChatMessageEntity message;

  ChatListMessageAdded({required this.message});
}
