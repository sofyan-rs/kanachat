import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
    required this.isMe,
    required this.time,
  });

  final String message;
  final bool isMe;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              // Limit max width but allow natural size for short messages
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color:
                    isMe
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    message,
                    style: TextStyle(
                      fontSize: 15,
                      color:
                          isMe
                              ? Theme.of(context).colorScheme.onPrimary
                              : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    time,
                    style: TextStyle(
                      color:
                          isMe
                              ? Theme.of(context).colorScheme.onSecondary
                              : Theme.of(
                                context,
                              ).colorScheme.onSurface.withValues(alpha: 0.6),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
