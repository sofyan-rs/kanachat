import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gpt_markdown/gpt_markdown.dart';

class TypewriterMarkdown extends StatefulWidget {
  final String markdownText;
  final Duration charDelay;
  final bool isMe;
  final bool isTyping;

  const TypewriterMarkdown({
    super.key,
    required this.markdownText,
    this.charDelay = const Duration(milliseconds: 20),
    required this.isMe,
    required this.isTyping,
  });

  @override
  State<TypewriterMarkdown> createState() => _TypewriterMarkdownState();
}

class _TypewriterMarkdownState extends State<TypewriterMarkdown> {
  String _visibleText = "";
  int _charIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (widget.isTyping) {
      _startTyping();
    } else {
      _visibleText = widget.markdownText;
    }
  }

  void _startTyping() {
    _timer = Timer.periodic(widget.charDelay, (timer) {
      if (_charIndex < widget.markdownText.length) {
        setState(() {
          _charIndex++;
          _visibleText = widget.markdownText.substring(0, _charIndex);
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: GptMarkdown(
        _visibleText,
        style: TextStyle(
          fontSize: 15,
          color:
              widget.isMe
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}
