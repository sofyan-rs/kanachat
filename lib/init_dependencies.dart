import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:kanachat/core/common/bloc/app_theme_cubit/app_theme_cubit.dart';
import 'package:kanachat/core/network/connection_checker.dart';
import 'package:kanachat/features/chat/data/datasources/local/chat_local_datasource.dart';
import 'package:kanachat/features/chat/data/datasources/remote/chat_remote_datasource.dart';
import 'package:kanachat/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:kanachat/features/chat/domain/repository/chat_repository.dart';
import 'package:kanachat/features/chat/domain/usecases/chat_history/delete_chat_history.dart';
import 'package:kanachat/features/chat/domain/usecases/chat_history/get_chat_history_list.dart';
import 'package:kanachat/features/chat/domain/usecases/chat_history/store_chat_history.dart';
import 'package:kanachat/features/chat/domain/usecases/chat_history/update_chat_history.dart';
import 'package:kanachat/features/chat/domain/usecases/chat_message/clear_chat_list.dart';
import 'package:kanachat/features/chat/domain/usecases/chat_message/get_chat_list_by_history_id.dart';
import 'package:kanachat/features/chat/domain/usecases/chat_message/post_chat.dart';
import 'package:kanachat/features/chat/domain/usecases/chat_message/store_chat.dart';
import 'package:kanachat/features/chat/presentation/bloc/chat_history_bloc/chat_history_bloc.dart';
import 'package:kanachat/features/chat/presentation/bloc/chat_list_bloc/chat_list_bloc.dart';
import 'package:kanachat/features/chat/presentation/bloc/chat_messages_cubit/chat_messages_cubit.dart';
import 'package:kanachat/features/chat/presentation/bloc/chat_typing_cubit/chat_typing_cubit.dart';
import 'package:kanachat/features/chat/presentation/bloc/current_history_cubit/current_history_cubit.dart';
import 'package:kanachat/features/chat/presentation/bloc/post_chat_bloc/post_chat_bloc.dart';
import 'package:kanachat/features/customization/data/datasources/local/chat_customization_local_datasource.dart';
import 'package:kanachat/features/customization/data/repositories/chat_customization_repository_impl.dart';
import 'package:kanachat/features/customization/domain/repository/chat_customization_repository.dart';
import 'package:kanachat/features/customization/domain/usecases/get_customization_setting.dart';
import 'package:kanachat/features/customization/domain/usecases/reset_customization_setting.dart';
import 'package:kanachat/features/customization/domain/usecases/save_customization_setting.dart';
import 'package:kanachat/features/customization/presentation/bloc/chat_customization_bloc.dart';

final GetIt sl = GetIt.instance;

Future<void> initDependencies() async {
  // Core
  sl.registerFactory(() => InternetConnection());
  sl.registerFactory<ConnectionChecker>(() => ConnectionCheckerImpl(sl()));

  _initThemes();
  _initCustomization();
  _initChat();
}

void _initThemes() {
  sl.registerLazySingleton(() => AppThemeCubit());
}

void _initCustomization() {
  // Data sources
  sl.registerLazySingleton<ChatCustomizationLocalDatasource>(
    () => ChatCustomizationLocalDatasourceImpl(),
  );

  // Repository
  sl.registerLazySingleton<ChatCustomizationRepository>(
    () => ChatCustomizationRepositoryImpl(localDatasource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetCustomizationSetting(sl()));
  sl.registerLazySingleton(() => SaveCustomizationSetting(sl()));
  sl.registerLazySingleton(() => ResetCustomizationSetting(sl()));

  // Bloc
  sl.registerLazySingleton(
    () => ChatCustomizationBloc(
      getCustomizationSetting: sl(),
      saveCustomizationSetting: sl(),
      resetCustomizationSetting: sl(),
    ),
  );
}

void _initChat() {
  // AI Model
  final model = FirebaseVertexAI.instance.generativeModel(
    model: 'gemini-2.0-flash',
  );

  // Data sources
  sl.registerLazySingleton<ChatLocalDatasource>(
    () => ChatLocalDatasourceImpl(),
  );
  sl.registerLazySingleton<ChatRemoteDatasource>(
    () => ChatRemoteDatasourceImpl(model: model),
  );

  // Repository
  sl.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(
      chatLocalDatasource: sl(),
      chatRemoteDatasource: sl(),
      connectionChecker: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => PostChat(sl()));
  sl.registerLazySingleton(() => GetChatListByHistoryId(sl()));
  sl.registerLazySingleton(() => StoreChat(sl()));
  sl.registerLazySingleton(() => ClearChatList(sl()));

  // Chat history
  sl.registerLazySingleton(() => GetChatHistoryList(sl()));
  sl.registerLazySingleton(() => StoreChatHistory(sl()));
  sl.registerLazySingleton(() => UpdateChatHistory(sl()));
  sl.registerLazySingleton(() => DeleteChatHistory(sl()));

  // Bloc
  sl.registerLazySingleton(() => CurrentHistoryCubit());
  sl.registerLazySingleton(() => ChatTypingCubit());
  sl.registerLazySingleton(
    () => ChatHistoryBloc(
      getChatHistoryList: sl(),
      storeChatHistory: sl(),
      updateChatHistory: sl(),
      deleteChatHistory: sl(),
    ),
  );
  sl.registerLazySingleton(() => ChatMessagesCubit());
  sl.registerLazySingleton(
    () => ChatListBloc(
      getChatList: sl(),
      storeChat: sl(),
      clearChatList: sl(),
      chatMessagesCubit: sl(),
    ),
  );
  sl.registerLazySingleton(() => PostChatBloc(sl()));
}
