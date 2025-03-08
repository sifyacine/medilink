import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  /// Variables
  final email = TextEditingController();
  final phone = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();
  // In your controller class
  final isEmailSelected = false.obs;
  final isPhoneSelected = false.obs;

  void selectEmail() {
    isEmailSelected.value = true;
    isPhoneSelected.value = false;
  }

  void selectPhone() {
    isEmailSelected.value = false;
    isPhoneSelected.value = true;
  }

}
