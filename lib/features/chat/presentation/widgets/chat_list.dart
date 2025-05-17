import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanachat/core/utils/string_formatter.dart';
import 'package:kanachat/features/chat/domain/entities/chat_message_entity.dart';
import 'package:kanachat/features/chat/presentation/bloc/chat_messages_cubit/chat_messages_cubit.dart';
import 'package:kanachat/features/chat/presentation/widgets/chat_bubble.dart';
import 'package:kanachat/features/chat/presentation/widgets/start_chat.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final _chatScrollController = ScrollController();

  @override
  void dispose() {
    _chatScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatMessagesCubit, List<ChatMessageEntity>>(
      builder: (context, state) {
        if (state.isNotEmpty) {
          return Expanded(
            child: ListView.custom(
              padding: const EdgeInsets.all(16),
              controller: _chatScrollController,
              reverse: true,
              childrenDelegate: SliverChildBuilderDelegate(
                (context, index) {
                  final chat = state[state.length - 1 - index];
                  return ChatBubble(
                    key: ValueKey(chat.id),
                    message:
                        chat.isUser
                            ? chat.message
                            : StringFormatter().extractResponseWithoutTitle(
                              chat.message,
                            ),
                    isMe: chat.isUser,
                    time: chat.createdAt,
                    isTyping: false,
                    // isTyping:
                    //     chatSortedByDate[index].isUser == false &&
                    //     chatSortedByDate.length - 1 == index,
                  );
                },
                childCount: state.length,
                findChildIndexCallback: (key) {
                  final ValueKey valueKey = key as ValueKey;
                  final val = state.indexWhere(
                    (chat) => chat.id.toString() == valueKey.value,
                  );
                  return state.length - 1 - val;
                },
              ),
            ),
          );
        }
        return StartChat();
      },
    );
  }
}
