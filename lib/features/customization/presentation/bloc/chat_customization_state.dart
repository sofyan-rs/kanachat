part of 'chat_customization_bloc.dart';

@immutable
sealed class ChatCustomizationState {}

final class ChatCustomizationInitial extends ChatCustomizationState {}

final class ChatCustomizationLoading extends ChatCustomizationState {}

final class ChatCustomizationLoaded extends ChatCustomizationState {
  final ChatCustomizationEntity customization;

  ChatCustomizationLoaded({required this.customization});
}

final class ChatCustomizationSaved extends ChatCustomizationState {}

final class ChatCustomizationError extends ChatCustomizationState {
  final String message;

  ChatCustomizationError({required this.message});
}

