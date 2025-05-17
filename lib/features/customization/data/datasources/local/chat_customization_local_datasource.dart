import 'dart:convert';

import 'package:kanachat/core/db/local_database.dart';
import 'package:kanachat/core/error/exceptions.dart';
import 'package:kanachat/features/customization/data/models/chat_customization_model.dart';
import 'package:sqflite/sqflite.dart';

abstract interface class ChatCustomizationLocalDatasource {
  Future<ChatCustomizationModel> getCustomizationSetting();
  Future<void> saveCustomizationSetting({
    required ChatCustomizationModel customization,
  });
  Future<void> resetCustomizationSetting();
}

class ChatCustomizationLocalDatasourceImpl
    implements ChatCustomizationLocalDatasource {
  @override
  Future<ChatCustomizationModel> getCustomizationSetting() async {
    try {
      final db = await LocalDatabase.database;
      final result = await db.query(
        'settings',
        where: 'key = ?',
        whereArgs: ['customization'],
      );
      if (result.isNotEmpty) {
        return ChatCustomizationModel.fromJson(
          jsonDecode(result.first['value'] as String),
        );
      } else {
        return const ChatCustomizationModel();
      }
    } catch (e) {
      throw LocalException('Failed to get customization setting: $e');
    }
  }

  @override
  Future<void> resetCustomizationSetting() async {
    try {
      final db = await LocalDatabase.database;
      await db.delete(
        'settings',
        where: 'key = ?',
        whereArgs: ['customization'],
      );
    } catch (e) {
      throw LocalException('Failed to reset customization setting: $e');
    }
  }

  @override
  Future<void> saveCustomizationSetting({
    required ChatCustomizationModel customization,
  }) async {
    try {
      final db = await LocalDatabase.database;
      await db.insert('settings', {
        'key': 'customization',
        'value': jsonEncode(customization.toJson()),
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      throw LocalException('Failed to save customization setting: $e');
    }
  }
}
