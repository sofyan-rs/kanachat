import 'package:kanachat/features/chat/domain/entities/chat_message_entity.dart';

class ChatListEntity {
  final String id;
  final String title;
  final List<ChatMessageEntity> messages;

  ChatListEntity({
    required this.id,
    required this.title,
    required this.messages,
  });

  factory ChatListEntity.fromJson(Map<String, dynamic> json) {
    return ChatListEntity(
      id: json['id'] as String,
      title: json['title'] as String,
      messages:
          (json['messages'] as List<dynamic>)
              .map((e) => ChatMessageEntity.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'messages': messages.map((e) => e.toJson()).toList(),
    };
  }
}
