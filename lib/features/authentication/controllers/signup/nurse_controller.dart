import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/authentication_repository.dart';
import '../../../../data/user/user_repository.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/loaders/loaders.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../models/nurse_model.dart';
import '../../screens/signup/verify_email.dart';

class NurseSignupController extends GetxController {
  static NurseSignupController get instance => Get.find<NurseSignupController>();

  /// Variables
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;
  final email = TextEditingController();
  final lastName = TextEditingController();
  final firstName = TextEditingController();
  final userName = TextEditingController();
  final password = TextEditingController();
  final phoneNumber = TextEditingController();
  final licenseNumber = TextEditingController();
  final specialization = TextEditingController();
  final workplace = TextEditingController();
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  final NetworkManager networkManager = Get.put(NetworkManager());

  /// -- Signup method
  Future<void> signup() async {
    try {
      // Start loading
      TFullScreenLoader.openLoadingDialog(
        'We are processing your information...',
        "assets/images/animations/141397-loading-juggle.json",
      );

      // Check the internet connection asynchronously
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(
          title: "No Internet Connection",
          message: "Please check your internet connection and try again.",
        );
        return;
      }

      // Validate the signup form
      if (!signupFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Privacy policy check
      if (!privacyPolicy.value) {
        TFullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(
          title: "Accept Privacy Policy",
          message:
          "In order to create an account, you must read and accept the privacy policy and terms of use.",
        );
        return;
      }

      // Register
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Save nurse data in Firestore
      final newNurse = NurseModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        username: userName.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        licenseNumber: licenseNumber.text.trim(),
        specialization: specialization.text.trim(),
        workplace: workplace.text.trim(),
        role: 'nurse',
      );
      final userRepository = Get.put(UserRepository());
      await userRepository.saveNurseRecord(newNurse);

      // Stop the loader before navigating
      TFullScreenLoader.stopLoading();

      // Show success message
      TLoaders.successSnackBar(
        title: "Congratulations",
        message: "Your nurse account has been created! Verify email to continue.",
      );

      // Navigate to the Verify Email screen
      Get.off(() => VerifyEmailScreen(email: email.text.trim()));
    } catch (e) {
      TFullScreenLoader.stopLoading();

      TLoaders.errorSnackBar(
        title: "Oh snap!",
        message: e.toString(),
      );
    }
  }
}