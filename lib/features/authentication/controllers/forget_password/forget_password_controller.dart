import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medilink/utils/helpers/network_manager.dart';

import '../../../../data/repositories/authentication_repository.dart';
import '../../../../utils/loaders/loaders.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../screens/password_configuration/reset_password.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  /// variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();
  final NetworkManager networkManager = Get.put(NetworkManager());

  /// Utility method to handle common pre-send tasks
  Future<bool> _prepareForEmailSend() async {
    // Start loading
    TFullScreenLoader.openLoadingDialog(
      "Sending reset email...",
      "assets/images/animations/loader-animation.json",
    );

    // Check internet connectivity
    final isConnected = await NetworkManager.instance.isConnected();
    if (!isConnected) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "No Internet", message: "Please check your internet connection and try again.");
      return false;
    }

    // Form validation
    if (!forgetPasswordFormKey.currentState!.validate()) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "Invalid Input", message: "Please enter a valid email address.");
      return false;
    }

    return true;
  }

  /// Send reset password email
  Future<void> sendPasswordResetEmail() async {
    if (!await _prepareForEmailSend()) return;

    try {
      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email.text.trim());

      // Remove the loader
      TFullScreenLoader.stopLoading();

      // Show success message
      TLoaders.successSnackBar(
        title: "Email Sent",
        message: "Email link sent to reset your password.".tr,
      );

      // Redirect to ResetPassword screen
      Get.to(() => ResetPassword(email: email.text.trim()));
    } catch (e) {
      _handleError(e);
    }
  }

  /// Resend reset password email
  Future<void> resendPasswordResetEmail(String email) async {
    if (!await _prepareForEmailSend()) return;

    try {
      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      // Remove the loader
      TFullScreenLoader.stopLoading();

      // Show success message
      TLoaders.successSnackBar(
        title: "Email Sent",
        message: "Email link sent to reset your password.".tr,
      );
    } catch (e) {
      _handleError(e);
    }
  }

  /// Error handler
  void _handleError(dynamic error) {
    TFullScreenLoader.stopLoading();
    TLoaders.errorSnackBar(title: "Error", message: error.toString());
  }
}
