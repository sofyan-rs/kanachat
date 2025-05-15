part of 'post_chat_bloc.dart';

@immutable
sealed class PostChatEvent {}

final class PostChatRequested extends PostChatEvent {
  final String userInput;
  final ChatCustomizationEntity customization;

  PostChatRequested({required this.userInput, required this.customization});
}
