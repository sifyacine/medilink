import 'package:flutter/material.dart';
import 'package:midilink/utils/constants/colors.dart';

class ChatMessageWidget extends StatelessWidget {
  final String message;
  final bool isUserMessage;

  ChatMessageWidget({
    required this.message,
    required this.isUserMessage,
  });

  @override
  Widget build(BuildContext context) {
    final alignment = isUserMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final color = isUserMessage ? TColors.primary : TColors.light;
    final radius = isUserMessage
        ? const BorderRadius.only(
      topLeft: Radius.circular(12),
      bottomLeft: Radius.circular(12),
      topRight: Radius.circular(12),
    )
        : const BorderRadius.only(
      topRight: Radius.circular(12),
      bottomRight: Radius.circular(12),
      topLeft: Radius.circular(12),
    );

    return Column(
      crossAxisAlignment: alignment,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: radius,
          ),
          child: Text(message),
        ),
      ],
    );
  }
}
