import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:kanachat/features/chat/domain/entities/chat_history_entity.dart';
import 'package:kanachat/features/chat/presentation/bloc/chat_history_bloc/chat_history_bloc.dart';
import 'package:kanachat/features/chat/presentation/bloc/chat_list_bloc/chat_list_bloc.dart';
import 'package:kanachat/features/chat/presentation/bloc/chat_messages_cubit/chat_messages_cubit.dart';
import 'package:kanachat/features/chat/presentation/bloc/chat_typing_cubit/chat_typing_cubit.dart';
import 'package:kanachat/features/chat/presentation/bloc/current_history_cubit/current_history_cubit.dart';

class ChatHistoryItem extends StatelessWidget {
  const ChatHistoryItem({super.key, required this.chatHistory});

  final ChatHistoryEntity chatHistory;

  @override
  Widget build(BuildContext context) {
    void checkHistoryChat(ChatHistoryEntity chatHistory) {
      // Set typing to false
      context.read<ChatTypingCubit>().setTyping(false);
      // Clear previous messages
      context.read<ChatMessagesCubit>().clearMessages();
      // Set current history
      context.read<CurrentHistoryCubit>().setCurrentHistory(chatHistory);
      // Load chat messages for the selected history
      context.read<ChatListBloc>().add(
        ChatListRequested(chatHistoryId: chatHistory.id),
      );
      // Navigate to the chat screen
      context.go('/');
      // AppRouter().navigate(route: '/', context: context, type: NavType.go);
    }

    void deleteChatHistory(
      BuildContext context,
      ChatHistoryEntity chatHistory,
    ) {
      // Delete the chat history
      context.read<ChatHistoryBloc>().add(
        ChatHistoryDeleted(chatHistoryId: chatHistory.id),
      );
      // Check if the current history is the one being deleted
      final currentHistory = context.read<CurrentHistoryCubit>().state;
      if (currentHistory.id == chatHistory.id) {
        // Clear the current history if it matches the deleted one
        context.read<CurrentHistoryCubit>().clearCurrentHistory();
        context.read<ChatMessagesCubit>().clearMessages();
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(bottom: 16),
      child: Slidable(
        key: ValueKey(chatHistory.id),
        endActionPane: ActionPane(
          motion: BehindMotion(),
          extentRatio: 0.2,
          children: [
            SlidableAction(
              onPressed: (context) {
                deleteChatHistory(context, chatHistory);
              },
              backgroundColor: Theme.of(context).colorScheme.error,
              // icon: SolarIconsBold.trashBin2,
              label: 'Delete',
              padding: EdgeInsets.all(10),
            ),
          ],
        ),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text(
                chatHistory.title,
                style: const TextStyle(fontSize: 16),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    checkHistoryChat(chatHistory);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
