import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kanachat/features/chat/presentation/screens/chatting_screen.dart';
import 'package:kanachat/features/customization/presentation/screens/customization_screen.dart';
import 'package:kanachat/features/history/presentation/screens/history_screen.dart';

enum NavType { push, go, replace }

class AppRouter {
  void navigate({
    required String route,
    required BuildContext context,
    NavType? type,
    Map<String, dynamic>? extra,
  }) {
    if (type == NavType.go) {
      context.go(route, extra: extra);
    } else if (type == NavType.replace) {
      context.replace(route, extra: extra);
    } else {
      context.push(route, extra: extra);
    }
  }

  final router = GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(
        name: 'chat',
        path: '/',
        builder: (context, state) => ChattingScreen(),
        routes: [
          GoRoute(
            name: 'customization',
            path: '/customization',
            builder: (context, state) {
              return CustomizationScreen();
            },
          ),
          GoRoute(
            name: 'history',
            path: '/history',
            builder: (context, state) {
              return HistoryScreen();
            },
          ),
        ],
      ),
    ],
  );
}
