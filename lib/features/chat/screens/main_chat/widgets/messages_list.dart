import 'package:flutter/material.dart';

import 'example_model_chat.dart';
import 'message_item.dart';


/// List of messages
class MessageList extends StatelessWidget {
  final List<MessageItem> messages;
  final Function(MessageItem) onItemTap;

  const MessageList({
    Key? key,
    required this.messages,
    required this.onItemTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (messages.isEmpty) {
      return const Center(
        child: Text('No messages.'),
      );
    }

    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final item = messages[index];
        return MessageListItem(
          item: item,
          onTap: () => onItemTap(item),
        );
      },
    );
  }
}
