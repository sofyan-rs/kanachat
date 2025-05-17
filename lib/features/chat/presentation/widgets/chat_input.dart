import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanachat/core/common/bloc/app_theme_cubit/app_theme_cubit.dart';
import 'package:kanachat/core/common/entities/app_theme_entity.dart';
import 'package:kanachat/core/db/local_database.dart';
import 'package:kanachat/core/themes/app_colors.dart';
import 'package:kanachat/core/utils/show_snackbar.dart';
import 'package:kanachat/core/utils/string_formatter.dart';
import 'package:kanachat/features/chat/domain/entities/chat_history_entity.dart';
import 'package:kanachat/features/chat/domain/entities/chat_message_entity.dart';
import 'package:kanachat/features/chat/presentation/bloc/chat_history_bloc/chat_history_bloc.dart';
import 'package:kanachat/features/chat/presentation/bloc/chat_list_bloc/chat_list_bloc.dart';
import 'package:kanachat/features/chat/presentation/bloc/chat_messages_cubit/chat_messages_cubit.dart';
import 'package:kanachat/features/chat/presentation/bloc/chat_typing_cubit/chat_typing_cubit.dart';
import 'package:kanachat/features/chat/presentation/bloc/current_history_cubit/current_history_cubit.dart';
import 'package:kanachat/features/chat/presentation/bloc/post_chat_bloc/post_chat_bloc.dart';
import 'package:kanachat/features/customization/domain/entities/chat_customization_entity.dart';
import 'package:kanachat/features/customization/presentation/bloc/chat_customization_bloc.dart';
import 'package:solar_icons/solar_icons.dart';

class ChatInput extends StatefulWidget {
  const ChatInput({super.key});

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final _inputChatController = TextEditingController();

  void _onSendMessage() {
    // Check current history
    final chatHistory = context.read<CurrentHistoryCubit>().state;
    var chatHistoryId = chatHistory.id;
    // If current history is empty, create a new one
    if (chatHistoryId == '') {
      if (kDebugMode) {
        print('chatHistoryId 1: $chatHistoryId');
      }
      final chatHistory = ChatHistoryEntity(
        id: LocalDatabase.generateUuid(),
        title: 'New Chat',
        createdAt: DateTime.now(),
        modifiedAt: DateTime.now(),
      );
      chatHistoryId = chatHistory.id;
      context.read<ChatHistoryBloc>().add(
        ChatHistoryStored(chatHistory: chatHistory),
      );
      context.read<CurrentHistoryCubit>().setCurrentHistory(chatHistory);
    }
    // Load chat customization
    context.read<ChatCustomizationBloc>().add(ChatCustomizationRequested());
    // Check if input is not empty
    if (_inputChatController.text.isNotEmpty) {
      final inputChat = _inputChatController.text.trim();
      // Create a new message
      if (kDebugMode) {
        print('chatHistoryId 2: $chatHistoryId');
      }
      final message = ChatMessageEntity(
        id: LocalDatabase.generateUuid(),
        message: inputChat,
        isUser: true,
        createdAt: DateTime.now(),
        modifiedAt: DateTime.now(),
        chatHistoryId: chatHistoryId,
      );
      if (kDebugMode) {
        print('chatHistoryId 3: ${message.chatHistoryId}');
      }
      // Add message to chat history
      context.read<ChatListBloc>().add(ChatListMessageAdded(message: message));
      // Get reply from the chat bot
      // Check if customization is loaded
      final customizationState = context.read<ChatCustomizationBloc>().state;
      final customization =
          customizationState is ChatCustomizationLoaded
              ? customizationState.customization
              : ChatCustomizationEntity(
                name: null,
                occupation: null,
                traits: null,
                additionalInfo: null,
              );
      // Send message to the chat bot
      context.read<PostChatBloc>().add(
        PostChatRequested(
          userInput: inputChat,
          customization: customization,
          chatHistory: context.read<ChatMessagesCubit>().state,
        ),
      );
      // Clear input field
      _inputChatController.clear();
    }
  }

  @override
  void dispose() {
    _inputChatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<AppThemeCubit, AppThemeEntity>(
          builder: (context, state) {
            return LinearProgressIndicator(
              value:
                  context.watch<PostChatBloc>().state is PostChatLoading
                      ? null
                      : 0,
              color: Theme.of(context).colorScheme.primary,
              backgroundColor: Theme.of(context).colorScheme.surface,
            );
          },
        ),
        Container(
          color: Theme.of(context).colorScheme.surface,
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Stack(
                children: [
                  BlocBuilder<AppThemeCubit, AppThemeEntity>(
                    builder: (context, state) {
                      return SizedBox(
                        width: double.infinity,
                        child: TextField(
                          minLines: 1,
                          maxLines: 4,
                          controller: _inputChatController,
                          decoration: InputDecoration(
                            hintText: 'Type a message...',
                            fillColor:
                                state.isDarkMode
                                    ? AppColors.darkSurface
                                    : AppColors.lightSurface,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 18,
                              horizontal: 16,
                            ),
                          ),
                          onTapOutside: (event) {
                            FocusScope.of(context).unfocus();
                          },
                        ),
                      );
                    },
                  ),
                  Positioned(
                    right: 0,
                    bottom: 4,
                    child: BlocListener<ChatListBloc, ChatListState>(
                      listener: (context, state) {
                        if (state is ChatListError) {
                          showSnackBar(
                            context: context,
                            message: state.message,
                          );
                        }
                      },
                      child: BlocListener<PostChatBloc, PostChatState>(
                        listener: (context, state) {
                          if (state is PostChatSuccess) {
                            // Add message from bot to chat history
                            final chatHistory =
                                context.read<CurrentHistoryCubit>().state;

                            context.read<ChatListBloc>().add(
                              ChatListMessageAdded(
                                message: ChatMessageEntity(
                                  id: LocalDatabase.generateUuid(),
                                  message: state.message,
                                  isUser: false,
                                  createdAt: DateTime.now(),
                                  modifiedAt: DateTime.now(),
                                  chatHistoryId: chatHistory.id,
                                ),
                              ),
                            );

                            // Update chat history title if it is 'New Chat'
                            if (chatHistory.title == 'New Chat') {
                              final newTitle =
                                  StringFormatter().extractTitle(
                                    state.message,
                                  ) ??
                                  'New Chat';
                              context.read<ChatHistoryBloc>().add(
                                ChatHistoryUpdated(
                                  chatHistoryId: chatHistory.id,
                                  newTitle: newTitle,
                                ),
                              );
                              context
                                  .read<CurrentHistoryCubit>()
                                  .setCurrentHistory(
                                    ChatHistoryEntity(
                                      id: chatHistory.id,
                                      title: newTitle,
                                      createdAt: chatHistory.createdAt,
                                      modifiedAt: DateTime.now(),
                                    ),
                                  );
                            }
                            context.read<ChatTypingCubit>().setTyping(true);
                          }
                        },
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(16),
                          ),
                          onPressed: _onSendMessage,
                          child: Icon(SolarIconsOutline.plain3, size: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ],
    );
  }
}
