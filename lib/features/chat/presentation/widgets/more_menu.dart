import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanachat/core/router/app_router.dart';
import 'package:kanachat/features/chat/presentation/bloc/chat_messages_cubit/chat_messages_cubit.dart';
import 'package:kanachat/features/chat/presentation/bloc/chat_typing_cubit/chat_typing_cubit.dart';
import 'package:kanachat/features/chat/presentation/bloc/current_history_cubit/current_history_cubit.dart';
import 'package:solar_icons/solar_icons.dart';

class MoreMenu extends StatelessWidget {
  const MoreMenu({super.key});

  @override
  Widget build(BuildContext context) {
    void newChat() {
      context.read<CurrentHistoryCubit>().clearCurrentHistory();
      context.read<ChatMessagesCubit>().clearMessages();
      context.read<ChatTypingCubit>().setTyping(false);
    }

    return PopupMenuButton(
      icon: const Icon(Icons.more_vert),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            onTap: newChat,
            child: Row(
              children: [
                Icon(SolarIconsOutline.addCircle, size: 20),
                const SizedBox(width: 8),
                Text('New Chat'),
              ],
            ),
          ),
          PopupMenuItem(
            onTap: () {
              AppRouter().navigate(route: '/history', context: context);
            },
            child: Row(
              children: [
                Icon(SolarIconsOutline.history, size: 20),
                const SizedBox(width: 8),
                const Text('History'),
              ],
            ),
          ),
          PopupMenuItem(
            onTap: () {
              AppRouter().navigate(route: '/customization', context: context);
            },
            child: Row(
              children: [
                Icon(SolarIconsOutline.settingsMinimalistic, size: 20),
                const SizedBox(width: 8),
                const Text('Customization'),
              ],
            ),
          ),
        ];
      },
    );
  }
}
