import 'package:get/get.dart';
import '../screens/chat_page/chat_page.dart';
import '../screens/main_chat/widgets/example_model_chat.dart';


/// GetX Controller
class MessageController extends GetxController {
  /// Current tab index (0 = Tout, 1 = Groupe, 2 = Privé)
  var currentTabIndex = 0.obs;

  /// Mock data for all messages
  final List<MessageItem> allMessages = [
    MessageItem(
      doctorName: 'Dr. Mansouri',
      lastMessage: 'Je n\'ai pas de fièvre, mais le mal de tête...',
      time: '10:24',
      unreadCount: 1,
      avatarUrl: null,
      isGroup: true
    ),
    MessageItem(
      doctorName: 'Dr. Mahdaoui',
      lastMessage: 'Bonjour, comment puis-je vous aider ?',
      time: '09:04',
      unreadCount: 0,
      avatarUrl: null,
      isGroup: false
    ),
    MessageItem(
      doctorName: 'Dr. Bouzid',
      lastMessage: 'Avez-vous de la fièvre ?',
      time: '08:57',
      unreadCount: 0,
      avatarUrl: null,
      isGroup: false
    ),
  ];

  /// You could filter messages for each tab if needed.
  /// For now, we'll just demonstrate using the same list.
  /// Implement actual filtering logic instead of returning allMessages
  List<MessageItem> get groupMessages => allMessages.where((msg) => msg.isGroup).toList();
  List<MessageItem> get privateMessages => allMessages.where((msg) => !msg.isGroup).toList();


  /// A method to handle tapping on a message
  void onMessageTap(MessageItem item) {
    Get.to(() => ChatScreen());

    print('Tapped on ${item.doctorName}');
  }

  /// A method for floating action button
  void onNewChatButtonPressed() {
    // Open new chat or do something
    print('New chat button pressed');
  }
}