import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink/data/user/user_repository.dart';

import '../../../../data/repositories/authentication_repository.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/loaders/loaders.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/validators/validation.dart';
import '../../models/patient_model.dart';
import '../../screens/signup/verify_email.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find<SignupController>();

  /// Variables
  final hidePassword = true.obs;
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userName = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();
  final privacyPolicy = true.obs;
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  final NetworkManager networkManager = Get.put(NetworkManager());

  /// Signup method
  void signup() async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog(
        'We are processing your information...',
          TImages.docerAnimation,
      );

      // Check Internet Connectivity
      final isConnected = await networkManager.isConnected();
      if (!isConnected) return;

      // Form Validation
      if (!signupFormKey.currentState!.validate()) return;

      // Privacy Policy Check
      if (!privacyPolicy.value) {
        TLoaders.warningSnackBar(
          title: 'Accept Privacy Policy',
          message:
          'In order to create account, you must first read and accept the Privacy Policy & Terms of Use.',
        );
        return;
      }

      // Register user in the Firebase Authentication & Save user data in the Firestore
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
        email.text.trim(),
        password.text.trim(),
      );

      // Save Authenticated user data in the Firebase Firestore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        username: userName.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicUrl: '',
        role: 'patient', // Added to empty model
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      // Show Success Message
      TLoaders.successSnackBar(title: "Congratulations",  message: "Your account has been created! verify your email to continue");

      // Move to Verify Email Screen
      Get.to(VerifyEmailScreen(email: email.text.trim(),));
    } catch (e) {
      // Show some Generic Error to the user
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      // Remove Loader
      TFullScreenLoader.stopLoading();
    }
  }

  /// Validation methods using TValidator
  String? validateFirstName(String? value) =>
      TValidator.validateFullName(value);

  String? validateLastName(String? value) => TValidator.validateFullName(value);

  String? validateUserName(String? value) => TValidator.validateUsername(value);

  String? validateEmail(String? value) => TValidator.validateEmail(value);

  String? validatePhoneNumber(String? value) =>
      TValidator.validatePhoneNumber(value);

  String? validatePassword(String? value) => TValidator.validatePassword(value);

  /// Clear controllers after successful signup
  void clearControllers() {
    firstName.clear();
    lastName.clear();
    userName.clear();
    email.clear();
    phoneNumber.clear();
    password.clear();
    privacyPolicy.value = true;
  }
}
