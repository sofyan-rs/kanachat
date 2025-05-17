import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanachat/features/chat/presentation/bloc/chat_history_bloc/chat_history_bloc.dart';
import 'package:kanachat/features/chat/presentation/widgets/chat_history_item.dart';
import 'package:solar_icons/solar_icons.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    context.read<ChatHistoryBloc>().add(ChatHistoryRequested());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('History')),
      body: BlocBuilder<ChatHistoryBloc, ChatHistoryState>(
        builder: (context, state) {
          if (state is ChatHistoryListLoaded) {
            if (state.chatHistoryList.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      SolarIconsOutline.chatRoundDots,
                      size: 70,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'No History Chats Found',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.chatHistoryList.length,
              itemBuilder: (context, index) {
                final chatHistory = state.chatHistoryList[index];
                return ChatHistoryItem(chatHistory: chatHistory);
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
