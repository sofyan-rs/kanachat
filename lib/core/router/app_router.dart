import 'package:go_router/go_router.dart';
import 'package:kanachat/features/chat/presentation/screens/chatting_screen.dart';
import 'package:kanachat/features/customization/presentation/screens/customization_screen.dart';
import 'package:kanachat/features/chat/presentation/screens/history_screen.dart';

class AppRouter {
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
