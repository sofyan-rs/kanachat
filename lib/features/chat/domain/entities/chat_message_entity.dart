class ChatMessageEntity {
  final String id;
  final String message;
  final bool isMe;
  final DateTime dateTime;

  ChatMessageEntity({
    required this.id,
    required this.message,
    required this.isMe,
    required this.dateTime,
  });

  factory ChatMessageEntity.fromJson(Map<String, dynamic> json) {
    return ChatMessageEntity(
      id: json['id'] as String,
      message: json['message'] as String,
      isMe: json['isMe'] as bool,
      dateTime: DateTime.parse(json['dateTime'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'isMe': isMe,
      'dateTime': dateTime.toIso8601String(),
    };
  }
}
