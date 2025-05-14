import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanachat/features/history/domain/entities/chat_history_entity.dart';
import 'package:kanachat/features/history/presentation/cubit/history_chat_cubit.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('History Chat')),
      body: BlocBuilder<HistoryChatCubit, ChatHistoryEntity>(
        builder: (context, state) {
          if (state.chatList.isEmpty) {
            return Center(child: Text('No chat history available'));
          }
          return ListView.builder(
            itemCount: state.chatList.length,
            itemBuilder: (context, index) {
              final chat = state.chatList[index];
              return ListTile(
                title: Text(chat.title),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    context.read<HistoryChatCubit>().removeChatHistory(chat.id);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
