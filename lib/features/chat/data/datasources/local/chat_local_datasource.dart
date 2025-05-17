import 'package:kanachat/core/db/local_database.dart';
import 'package:kanachat/core/error/exceptions.dart';
import 'package:kanachat/features/chat/data/models/chat_history_model.dart';
import 'package:kanachat/features/chat/data/models/chat_message_model.dart';
import 'package:sqflite/sqflite.dart';

abstract interface class ChatLocalDatasource {
  Future<List<ChatMessageModel>> getChatMessageList();
  Future<ChatMessageModel> storeChatMessage({
    required ChatMessageModel chatMessage,
  });
  Future<void> clearChatMessageList();
  Future<List<ChatHistoryModel>> getChatHistoryList();
  Future<List<ChatMessageModel>> getChatMessageListByChatHistoryId({
    required String chatHistoryId,
  });
  Future<ChatHistoryModel> storeChatHistory({
    required ChatHistoryModel chatHistory,
  });
  Future<ChatHistoryModel> updateChatHistory({
    required String chatHistoryId,
    required String newTitle,
  });
  Future<void> clearChatHistoryList();
  Future<void> deleteChatHistory({required String chatHistoryId});
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

  @override
  Future<void> clearChatHistoryList() async {
    try {
      final db = await LocalDatabase.database;
      await db.delete('chat_history');
    } catch (e) {
      throw LocalException('Failed to clear chat history list: $e');
    }
  }

  @override
  Future<void> deleteChatHistory({required String chatHistoryId}) async {
    try {
      final db = await LocalDatabase.database;
      await db.delete(
        'chat_history',
        where: 'id = ?',
        whereArgs: [chatHistoryId],
      );
      await db.delete(
        'chat_message',
        where: 'chat_history_id = ?',
        whereArgs: [chatHistoryId],
      );
    } catch (e) {
      throw LocalException('Failed to delete chat history: $e');
    }
  }

  @override
  Future<List<ChatHistoryModel>> getChatHistoryList() async {
    try {
      final db = await LocalDatabase.database;
      final result = await db.query('chat_history');
      return result.map((e) => ChatHistoryModel.fromJson(e)).toList();
    } catch (e) {
      throw LocalException('Failed to get chat history list: $e');
    }
  }

  @override
  Future<List<ChatMessageModel>> getChatMessageListByChatHistoryId({
    required String chatHistoryId,
  }) async {
    try {
      // print(chatHistoryId);
      final db = await LocalDatabase.database;
      final result = await db.query(
        'chat_message',
        where: 'chat_history_id = ?',
        whereArgs: [chatHistoryId],
      );
      // print(result);
      return result.map((e) => ChatMessageModel.fromJson(e)).toList();
    } catch (e) {
      throw LocalException(
        'Failed to get chat message list by chat history id: $e',
      );
    }
  }

  @override
  Future<ChatHistoryModel> storeChatHistory({
    required ChatHistoryModel chatHistory,
  }) async {
    try {
      final db = await LocalDatabase.database;
      await db.insert(
        'chat_history',
        chatHistory.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return chatHistory;
    } catch (e) {
      throw LocalException('Failed to store chat history: $e');
    }
  }

  @override
  Future<ChatHistoryModel> updateChatHistory({
    required String chatHistoryId,
    required String newTitle,
  }) async {
    try {
      final db = await LocalDatabase.database;
      await db.update(
        'chat_history',
        {'title': newTitle, 'modified_at': DateTime.now().toIso8601String()},
        where: 'id = ?',
        whereArgs: [chatHistoryId],
      );
      final result = await db.query(
        'chat_history',
        where: 'id = ?',
        whereArgs: [chatHistoryId],
      );
      return ChatHistoryModel.fromJson(result.first);
    } catch (e) {
      throw LocalException('Failed to update chat history: $e');
    }
  }
}
