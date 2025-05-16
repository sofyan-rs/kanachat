import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanachat/core/router/app_router.dart';
import 'package:kanachat/features/chat/presentation/bloc/chat_list_bloc/chat_list_bloc.dart';
import 'package:solar_icons/solar_icons.dart';

class MoreMenu extends StatelessWidget {
  const MoreMenu({super.key});

  @override
  Widget build(BuildContext context) {
    void clearChat() {
      showDialog(
        context: context,
        builder: (buildContext) {
          return AlertDialog(
            title: const Text('Clear Chat'),
            content: const Text('Are you sure you want to clear the chat?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('No'),
              ),
              FilledButton(
                onPressed: () {
                  context.read<ChatListBloc>().add(ChatListCleared());
                  Navigator.of(context).pop();
                },
                child: const Text('Yes'),
              ),
            ],
          );
        },
      );
    }

    return PopupMenuButton(
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            onTap: clearChat,
            child: Row(
              children: [
                Icon(SolarIconsOutline.trashBin2, size: 20),
                const SizedBox(width: 8),
                Text('Clear Chat'),
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
