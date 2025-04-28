// message_input_widget.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/chat_page_controller.dart';

class MessageInputWidget extends StatelessWidget {
  MessageInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final controller  = Get.put(MessageInputController());

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: isDark ? TColors.dark : TColors.light,
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.add_circle_outline,
                color: isDark ? TColors.white : TColors.dark),
            onPressed: controller.showAttachmentOptions,
          ),
          Expanded(
            child: TextField(
              controller: controller.textController,
              decoration: InputDecoration(
                hintText: 'Envoyer un message...',
                hintStyle: TextStyle(color: isDark ? TColors.grey : TColors.darkGrey),
                border: InputBorder.none,
              ),
              onSubmitted: (_) => controller.sendTextMessage(),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: TColors.primary),
            onPressed: controller.sendTextMessage,
          ),
        ],
      ),
    );
  }
}

// attachment_option_widget.dart
class AttachmentOptionWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const AttachmentOptionWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? TColors.darkerGrey : TColors.grey,
              shape: BoxShape.circle,
            ),
            child: Icon(icon,
                color: isDark ? TColors.white : TColors.dark,
                size: 28),
          ),
          const SizedBox(height: 8),
          Text(label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: isDark ? TColors.white : TColors.dark)),
        ],
      ),
    );
  }
}

// message_input_controller.dart
class MessageInputController extends GetxController {
  final textController = TextEditingController();
  final chatController = Get.put(ChatController());
  final attachmentOptions = const [
    {'title': 'Camera', 'icon': Icons.camera_alt},
    {'title': 'Gallery', 'icon': Icons.photo_library},
    {'title': 'Document', 'icon': Icons.insert_drive_file},
  ];

  void sendTextMessage() {
    if (textController.text.trim().isNotEmpty) {
      chatController.sendMessage(textController.text.trim(), true);
      textController.clear();
    }
  }

  void showAttachmentOptions() {
    final isDark = THelperFunctions.isDarkMode(Get.context!);

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: isDark ? TColors.dark : TColors.light,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: attachmentOptions.map((option) =>
                  AttachmentOptionWidget(
                    icon: option['icon']! as IconData,
                    label: option['title']! as String,
                    onTap: () => handleAttachmentSelection(option['title']! as String),
                  ),
              ).toList(),
            ),
            const SizedBox(height: TSizes.defaultSpace),
          ],
        ),
      ),
    );
  }

  void handleAttachmentSelection(String type) {
    Get.back();
    switch(type) {
      case 'Camera':
        chatController.pickImageFromCamera();
        break;
      case 'Gallery':
        chatController.pickImageFromGallery();
        break;
      case 'Document':
        chatController.pickDocument();
        break;
    }
  }
}