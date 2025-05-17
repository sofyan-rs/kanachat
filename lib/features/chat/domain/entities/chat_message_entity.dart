class ChatMessageEntity {
  final String id;
  final String message;
  final bool isUser;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final String? chatHistoryId;

  ChatMessageEntity({
    required this.id,
    required this.message,
    required this.isUser,
    required this.createdAt,
    required this.modifiedAt,
    this.chatHistoryId,
  });
}
