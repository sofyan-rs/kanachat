import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanachat/core/usecase/usecase.dart';
import 'package:kanachat/features/chat/domain/entities/chat_history_entity.dart';
import 'package:kanachat/features/chat/domain/usecases/chat_history/delete_chat_history.dart';
import 'package:kanachat/features/chat/domain/usecases/chat_history/get_chat_history_list.dart';
import 'package:kanachat/features/chat/domain/usecases/chat_history/store_chat_history.dart';

part 'chat_history_event.dart';
part 'chat_history_state.dart';

class ChatHistoryBloc extends Bloc<ChatHistoryEvent, ChatHistoryState> {
  final GetChatHistoryList getChatHistoryList;
  final StoreChatHistory storeChatHistory;
  final DeleteChatHistory deleteChatHistory;

  ChatHistoryBloc({
    required this.getChatHistoryList,
    required this.storeChatHistory,
    required this.deleteChatHistory,
  }) : super(ChatHistoryInitial()) {
    on<ChatHistoryRequested>(
      (event, emit) => _onGetChatHistoryList(event, emit),
    );
    on<ChatHistoryStored>((event, emit) => _onStoreChatHistory(event, emit));
    on<ChatHistoryDeleted>((event, emit) => _onDeleteChatHistory(event, emit));
  }

  void _onGetChatHistoryList(
    ChatHistoryRequested event,
    Emitter<ChatHistoryState> emit,
  ) async {
    emit(ChatHistoryLoading());
    final res = await getChatHistoryList(NoParams());
    res.fold(
      (l) => emit(ChatHistoryError(message: l.message)),
      (r) => emit(ChatHistoryListLoaded(chatHistoryList: r)),
    );
  }

  void _onStoreChatHistory(
    ChatHistoryStored event,
    Emitter<ChatHistoryState> emit,
  ) async {
    emit(ChatHistoryLoading());
    final res = await storeChatHistory(
      StoreChatHistoryParams(chatHistory: event.chatHistory),
    );
    res.fold(
      (l) => emit(ChatHistoryError(message: l.message)),
      (r) => emit(ChatHistorySaved(message: r)),
    );
  }

  void _onDeleteChatHistory(
    ChatHistoryDeleted event,
    Emitter<ChatHistoryState> emit,
  ) async {
    emit(ChatHistoryLoading());
    final res = await deleteChatHistory(
      DeleteChatHistoryParams(chatHistoryId: event.chatHistoryId),
    );
    res.fold(
      (l) => emit(ChatHistoryError(message: l.message)),
      (r) => emit(ChatHistoryRemoved()),
    );
  }
}
