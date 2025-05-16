import 'dart:convert';

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
    final chatHistory = context.read<CurrentHistoryCubit>().state;
    print(chatHistory.id);
    context.read<ChatCustomizationBloc>().add(ChatCustomizationRequested());
    final customization = context.read<ChatCustomizationBloc>().state;
    if (_inputChatController.text.isNotEmpty) {
      final message = ChatMessageEntity(
        id: LocalDatabase.generateUuid(),
        message: _inputChatController.text.trim(),
        isUser: true,
        createdAt: DateTime.now(),
        chatHistoryId: chatHistory.id,
      );
      context.read<ChatListBloc>().add(ChatListMessageAdded(message: message));
      context.read<PostChatBloc>().add(
        PostChatRequested(
          userInput: _inputChatController.text.trim(),
          customization:
              customization is ChatCustomizationLoaded
                  ? customization.customization
                  : ChatCustomizationEntity(
                    name: null,
                    occupation: null,
                    traits: null,
                    additionalInfo: null,
                  ),
          chatHistory: context.read<ChatMessagesCubit>().state,
        ),
      );
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
        LinearProgressIndicator(
          value:
              context.watch<PostChatBloc>().state is PostChatLoading ? null : 0,
          color: Theme.of(context).colorScheme.primary,
          backgroundColor: Theme.of(context).colorScheme.surface,
        ),
        Container(
          color: Theme.of(context).colorScheme.surface,
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: BlocBuilder<AppThemeCubit, AppThemeEntity>(
                  builder: (context, state) {
                    return TextField(
                      controller: _inputChatController,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        fillColor:
                            state.isDarkMode
                                ? AppColors.darkBackground
                                : AppColors.lightBackground,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          borderSide: BorderSide(
                            color: AppColors.primary,
                            width: 1.5,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 20,
                        ),
                      ),
                      onTapOutside: (event) {
                        FocusScope.of(context).unfocus();
                      },
                    );
                  },
                ),
              ),
              const SizedBox(width: 8),
              BlocListener<ChatListBloc, ChatListState>(
                listener: (context, state) {
                  if (state is ChatListError) {
                    showSnackBar(context: context, message: state.message);
                  }
                  if (state is ChatListLoaded) {
                    // _goToBottom();
                  }
                },
                child: BlocListener<PostChatBloc, PostChatState>(
                  listener: (context, state) {
                    if (state is PostChatSuccess) {
                      final chatHistory =
                          context.read<CurrentHistoryCubit>().state;

                      context.read<ChatListBloc>().add(
                        ChatListMessageAdded(
                          message: ChatMessageEntity(
                            id: LocalDatabase.generateUuid(),
                            message: state.message,
                            isUser: false,
                            createdAt: DateTime.now(),
                            chatHistoryId: chatHistory.id,
                          ),
                        ),
                      );

                      if (chatHistory.title == 'New Chat') {
                        context.read<ChatHistoryBloc>().add(
                          ChatHistoryStored(
                            chatHistory: ChatHistoryEntity(
                              id: chatHistory.id,
                              title:
                                  JsonDecoder().convert(
                                    StringFormatter().cleanJsonOutput(
                                      state.message,
                                    ),
                                  )['title'] ??
                                  'New Chat',
                              createdAt: DateTime.now(),
                            ),
                          ),
                        );
                      }

                      // context.read<ChatTypingCubit>().setTyping(true);
                    }
                  },
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(16),
                    ),
                    onPressed: _onSendMessage,
                    child: Icon(SolarIconsOutline.plain3, size: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
