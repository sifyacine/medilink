import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medilink/features/chat/screens/chat_page/widgets/chat_message_widget.dart';
import 'package:medilink/features/chat/screens/chat_page/widgets/message_input_widget.dart';

import '../../controllers/chat_page_controller.dart';


class ChatScreen extends StatelessWidget {
  final controller = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dr. Mansouri'),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Iconsax.video)),
          IconButton(onPressed: (){}, icon: Icon(Iconsax.call)),
          IconButton(onPressed: (){}, icon: Icon(Iconsax.setting)),

        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return ListView.builder(
                padding: const EdgeInsets.all(16.0),
                reverse: true,
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final message = controller.messages[index];
                  return ChatMessageWidget(
                    message: message.text,
                    isUserMessage: message.isUserMessage,
                  );
                },
              );
            }),
          ),
          MessageInputWidget(),
        ],
      ),
    );
  }
}
