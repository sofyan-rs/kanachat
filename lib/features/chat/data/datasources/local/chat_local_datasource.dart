import 'package:kanachat/core/db/local_database.dart';
import 'package:kanachat/core/error/exceptions.dart';
import 'package:kanachat/features/chat/data/models/chat_message_model.dart';
import 'package:sqflite/sqflite.dart';

abstract interface class ChatLocalDatasource {
  Future<List<ChatMessageModel>> getChatMessageList();
  Future<ChatMessageModel> storeChatMessage({
    required ChatMessageModel chatMessage,
  });
  Future<void> clearChatMessageList();
}

class ChatLocalDatasourceImpl implements ChatLocalDatasource {
  @override
  Future<List<ChatMessageModel>> getChatMessageList() async {
    try {
      final db = await LocalDatabase.database;
      final result = await db.query('chat_message');
      return result.map((e) => ChatMessageModel.fromJson(e)).toList();
    } catch (e) {
      throw LocalException('Failed to get chat message list: $e');
    }
  }

  @override
  Future<ChatMessageModel> storeChatMessage({
    required ChatMessageModel chatMessage,
  }) async {
    try {
      // print(chatMessage.toJson());
      final db = await LocalDatabase.database;
      await db.insert(
        'chat_message',
        chatMessage.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return chatMessage;
    } catch (e) {
      throw LocalException('Failed to store chat message: $e');
    }
  }

  @override
  Future<void> clearChatMessageList() async {
    try {
      final db = await LocalDatabase.database;
      await db.delete('chat_message');
    } catch (e) {
      throw LocalException('Failed to clear chat message list: $e');
    }
  }
}
