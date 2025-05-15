import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanachat/core/usecase/usecase.dart';
import 'package:kanachat/features/chat/domain/entities/chat_message_entity.dart';
import 'package:kanachat/features/chat/domain/usecases/get_chat_list.dart';
import 'package:kanachat/features/chat/domain/usecases/store_chat.dart';
import 'package:kanachat/features/chat/presentation/bloc/chat_messages_cubit/chat_messages_cubit.dart';

part 'chat_list_event.dart';
part 'chat_list_state.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  final GetChatList getChatList;
  final StoreChat storeChat;
  final ChatMessagesCubit chatMessagesCubit;

  ChatListBloc({
    required this.getChatList,
    required this.storeChat,
    required this.chatMessagesCubit,
  }) : super(ChatListInitial()) {
    on<ChatListRequested>((event, emit) => _onGetChatList(event, emit));
    on<ChatListMessageAdded>(
      (event, emit) => _onCustomizationSaved(event, emit),
    );
  }

  void _onGetChatList(
    ChatListRequested event,
    Emitter<ChatListState> emit,
  ) async {
    emit(ChatListLoading());
    final res = await getChatList(NoParams());
    res.fold((l) => emit(ChatListError(message: l.message)), (r) {
      emit(ChatListLoaded(messages: r));
      chatMessagesCubit.setMessages(r);
    });
  }

  void _onCustomizationSaved(
    ChatListMessageAdded event,
    Emitter<ChatListState> emit,
  ) async {
    emit(ChatListLoading());
    final res = await storeChat(StoreChatParams(chatMessage: event.message));
    res.fold((l) => emit(ChatListError(message: l.message)), (r) {
      emit(ChatListMessageSaved());
      add(ChatListRequested());
      // chatMessagesCubit.addMessage(event.message);a
    });
  }
}
