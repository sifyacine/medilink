import 'package:get/get.dart';

class MessageModel {
  String text;
  bool isUserMessage;

  MessageModel({required this.text, required this.isUserMessage});
}

class ChatController extends GetxController {
  var messages = <MessageModel>[].obs;

  void sendMessage(String text, bool isUserMessage) {
    messages.insert(0, MessageModel(text: text, isUserMessage: isUserMessage));
  }
  void pickImageFromCamera() {
    // TODO: implement pickImageFromCamera
  }
  void pickImageFromGallery() {
    // TODO: implement pickImageFromGallery
  }
  void pickDocument() {
    // TODO: implement pickDocument
  }
}
