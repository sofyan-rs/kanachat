import 'package:kanachat/features/chat/domain/entities/chat_message_entity.dart';

class ChatMessageModel extends ChatMessageEntity {
  ChatMessageModel({
    required super.id,
    required super.message,
    required super.isUser,
    required super.createdAt,
    required super.chatHistoryId,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['id'] as int?,
      message: json['message'] as String,
      isUser: json['is_user'] as int == 1 ? true : false,
      createdAt: DateTime.parse(json['created_at'] as String),
      chatHistoryId: json['chat_history_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'message': message,
      'is_user': isUser ? 1 : 0,
      'created_at': createdAt.toIso8601String(),
      if (chatHistoryId != null) 'chat_history_id': chatHistoryId,
    };
  }

  factory ChatMessageModel.fromEntity(ChatMessageEntity entity) {
    return ChatMessageModel(
      id: entity.id,
      message: entity.message,
      isUser: entity.isUser,
      createdAt: entity.createdAt,
      chatHistoryId: entity.chatHistoryId,
    );
  }
}
