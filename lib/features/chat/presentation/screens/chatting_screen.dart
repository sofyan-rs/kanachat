import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanachat/core/common/bloc/app_theme_cubit/app_theme_cubit.dart';
import 'package:kanachat/core/common/entities/app_theme_entity.dart';
import 'package:kanachat/features/chat/presentation/bloc/chat_list_bloc/chat_list_bloc.dart';
import 'package:kanachat/features/chat/presentation/bloc/current_history_cubit/current_history_cubit.dart';
import 'package:kanachat/features/chat/presentation/widgets/chat_input.dart';
import 'package:kanachat/features/chat/presentation/widgets/chat_list.dart';
import 'package:kanachat/features/chat/presentation/widgets/more_menu.dart';
import 'package:kanachat/features/customization/presentation/bloc/chat_customization_bloc.dart';
import 'package:solar_icons/solar_icons.dart';

class ChattingScreen extends StatefulWidget {
  const ChattingScreen({super.key});

  @override
  State<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  @override
  void initState() {
    // Load chat history
    final chatHistory = context.read<CurrentHistoryCubit>().state;
    // if (chatHistory.id == '') {
    //   final chatHistory = ChatHistoryEntity(
    //     id: LocalDatabase.generateUuid(),
    //     title: 'New Chat',
    //     createdAt: DateTime.now(),
    //   );
    //   context.read<ChatHistoryBloc>().add(
    //     ChatHistoryStored(chatHistory: chatHistory),
    //   );
    //   context.read<CurrentHistoryCubit>().setCurrentHistory(chatHistory);
    // }
    context.read<ChatListBloc>().add(
      ChatListRequested(chatHistoryId: chatHistory.id),
    );
    // Load chat customization
    context.read<ChatCustomizationBloc>().add(ChatCustomizationRequested());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Row(
          children: [
            Icon(
              SolarIconsOutline.chatRoundLine,
              size: 24,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 8),
            const Text(
              'KanaChat',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        actions: [
          BlocBuilder<AppThemeCubit, AppThemeEntity>(
            builder: (context, state) {
              return IconButton(
                icon: Icon(
                  state.isDarkMode ? SolarIconsBold.moon : SolarIconsBold.sun,
                ),
                onPressed: () {
                  context.read<AppThemeCubit>().toggleTheme();
                },
              );
            },
          ),
          MoreMenu(),
        ],
      ),
      body: Column(children: [ChatList(), ChatInput()]),
    );
  }
}
