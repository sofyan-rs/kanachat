part of 'chat_customization_bloc.dart';

@immutable
sealed class ChatCustomizationEvent {}

final class ChatCustomizationRequested extends ChatCustomizationEvent {}

final class ChatCustomizationUpdated extends ChatCustomizationEvent {
  final ChatCustomizationEntity customization;

  ChatCustomizationUpdated({required this.customization});
}

final class ChatCustomizationReset extends ChatCustomizationEvent {}
