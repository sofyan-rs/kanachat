part of 'post_chat_bloc.dart';

@immutable
sealed class PostChatState {}

final class PostChatInitial extends PostChatState {}

final class PostChatLoading extends PostChatState {}

final class PostChatSuccess extends PostChatState {
  final String message;

  PostChatSuccess({required this.message});
}

final class PostChatError extends PostChatState {
  final String message;

  PostChatError({required this.message});
}
