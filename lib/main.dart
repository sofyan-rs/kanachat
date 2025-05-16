import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:kanachat/core/common/bloc/app_theme_cubit/app_theme_cubit.dart';
import 'package:kanachat/core/common/entities/app_theme_entity.dart';
import 'package:kanachat/core/router/app_router.dart';
import 'package:kanachat/core/themes/app_themes.dart';
import 'package:kanachat/features/chat/presentation/bloc/chat_history_bloc/chat_history_bloc.dart';
import 'package:kanachat/features/chat/presentation/bloc/chat_list_bloc/chat_list_bloc.dart';
import 'package:kanachat/features/chat/presentation/bloc/chat_messages_cubit/chat_messages_cubit.dart';
import 'package:kanachat/features/chat/presentation/bloc/current_history_cubit/current_history_cubit.dart';
import 'package:kanachat/features/chat/presentation/bloc/post_chat_bloc/post_chat_bloc.dart';
import 'package:kanachat/features/customization/presentation/bloc/chat_customization_bloc.dart';
import 'package:kanachat/init_dependencies.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory:
        kIsWeb
            ? HydratedStorageDirectory.web
            : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );
  // Initialize dependencies
  await initDependencies();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const KanaChatApp()));
}

class KanaChatApp extends StatelessWidget {
  const KanaChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<AppThemeCubit>()),
        BlocProvider(create: (context) => sl<ChatCustomizationBloc>()),
        BlocProvider(create: (context) => sl<CurrentHistoryCubit>()),
        BlocProvider(create: (context) => sl<ChatHistoryBloc>()),
        BlocProvider(create: (context) => sl<ChatMessagesCubit>()),
        BlocProvider(create: (context) => sl<ChatListBloc>()),
        BlocProvider(create: (context) => sl<PostChatBloc>()),
      ],
      child: BlocBuilder<AppThemeCubit, AppThemeEntity>(
        builder: (context, state) {
          return MaterialApp.router(
            themeMode: state.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            theme: AppThemes().lightTheme,
            darkTheme: AppThemes().darkTheme,
            debugShowCheckedModeBanner: false,
            title: 'KanaChat',
            routerConfig: AppRouter().router,
          );
        },
      ),
    );
  }
}
