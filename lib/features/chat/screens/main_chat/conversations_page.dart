import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/custom_shapes/containers/animated_container_tabbar.dart';
import '../../../../utils/constants/colors.dart';
import '../../controllers/chat_controller.dart';
import 'widgets/example_model_chat.dart';
import 'widgets/messages_list.dart';

class MessagesPage extends StatelessWidget {
  MessagesPage({Key? key}) : super(key: key);
  final MessageController controller = Get.put(MessageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: const Text('Messages'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Iconsax.search_normal),
          )
        ],
      ),
      body: Column(
        children: [
          // Wrap your tab bar with Obx to update the UI on changes
          Obx(
                () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: SelectableOption(
                      title: 'All',
                      isSelected: controller.currentTabIndex.value == 0,
                      onTap: () => controller.currentTabIndex.value = 0,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: SelectableOption(
                      title: 'Group',
                      isSelected: controller.currentTabIndex.value == 1,
                      onTap: () => controller.currentTabIndex.value = 1,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: SelectableOption(
                      title: 'Private',
                      isSelected: controller.currentTabIndex.value == 2,
                      onTap: () => controller.currentTabIndex.value = 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // The message list is already wrapped in Obx
          Expanded(
            child: Obx(() {
              final index = controller.currentTabIndex.value;
              List<MessageItem> messages;

              if (index == 0) {
                messages = controller.allMessages;
              } else if (index == 1) {
                messages = controller.groupMessages;
              } else {
                messages = controller.privateMessages;
              }

              return MessageList(
                messages: messages,
                onItemTap: controller.onMessageTap,
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: TColors.primary,
        // Navigate directly to the ChatScreen when tapped
        onPressed: () {
        },
        child: const Icon(Icons.chat, color: Colors.white),
      ),
    );
  }
}
