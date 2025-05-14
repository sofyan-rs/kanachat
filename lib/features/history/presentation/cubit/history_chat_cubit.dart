import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:kanachat/features/chat/domain/entities/chat_list_entity.dart';
import 'package:kanachat/features/history/domain/entities/chat_history_entity.dart';

class HistoryChatCubit extends HydratedCubit<ChatHistoryEntity> {
  HistoryChatCubit() : super(ChatHistoryEntity(chatList: []));

  void addChatHistory(ChatListEntity chat) {
    final updatedChatList = List<ChatListEntity>.from(state.chatList)
      ..add(chat);
    emit(ChatHistoryEntity(chatList: updatedChatList));
  }

  void removeChatHistory(String idChatHistory) {
    final updatedChatList =
        state.chatList.where((chat) => chat.id != idChatHistory).toList();
    emit(ChatHistoryEntity(chatList: updatedChatList));
  }

  @override
  ChatHistoryEntity? fromJson(Map<String, dynamic> json) {
    final chatList =
        (json['chatList'] as List<dynamic>)
            .map((e) => ChatListEntity.fromJson(e))
            .toList();
    return ChatHistoryEntity(chatList: chatList);
  }

  @override
  Map<String, dynamic>? toJson(ChatHistoryEntity state) {
    return {'chatList': state.chatList.map((e) => e.toJson()).toList()};
  }
}
