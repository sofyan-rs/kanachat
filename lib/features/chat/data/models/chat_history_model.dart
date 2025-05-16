import 'package:kanachat/features/chat/domain/entities/chat_history_entity.dart';

class ChatHistoryModel extends ChatHistoryEntity {
  ChatHistoryModel({
    required super.id,
    required super.title,
    required super.createdAt,
  });

  factory ChatHistoryModel.fromJson(Map<String, dynamic> json) {
    return ChatHistoryModel(
      id: json['id'] as String,
      title: json['title'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory ChatHistoryModel.fromEntity(ChatHistoryEntity entity) {
    return ChatHistoryModel(
      id: entity.id,
      title: entity.title,
      createdAt: entity.createdAt,
    );
  }
}
