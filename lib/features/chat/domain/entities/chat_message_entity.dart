class ChatMessageEntity {
  final int? id;
  final String message;
  final bool isUser;
  final DateTime createdAt;
  final String? chatHistoryId;

  ChatMessageEntity({
    this.id,
    required this.message,
    required this.isUser,
    required this.createdAt,
    this.chatHistoryId,
  });
}
