import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SignupController extends GetxController {
  static SignupController get instance => Get.find<SignupController>();

  /// Variables
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;
  final email = TextEditingController();
  final lastName = TextEditingController();
  final firstName = TextEditingController();
  final userName = TextEditingController();
  final password = TextEditingController();
  final phoneNumber = TextEditingController();
  final serviceType = ''.obs; // Added for providers
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  late final bool isParent;

  /// -- Signup method


}
