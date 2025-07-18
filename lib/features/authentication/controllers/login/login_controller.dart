import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../data/repositories/authentication_repository.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/loaders/loaders.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../personalization/controllers/user_controller.dart';

class LoginController extends GetxController {
  /// Variables
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());

  @override
  void onInit() {
    super.onInit();
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
  }

  /// Email and password sign-in
  Future<void> emailAndPasswordSignIn() async {
    if (!loginFormKey.currentState!.validate()) {
      // Show error if the form is not valid
      TLoaders.errorSnackBar(title: 'Validation Error', message: 'Please fill in all fields correctly.');
      return;
    }

    try {
      // Start loading
      TFullScreenLoader.openLoadingDialog("Logging you in...", "assets/images/animations/loader-animation.json");

      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(title: 'No Internet', message: 'Please check your internet connection.');
        return;
      }

      // Save data if "remember me" is checked
      if (rememberMe.value) {
        localStorage.write("REMEMBER_ME_EMAIL", email.text.trim());
        localStorage.write("REMEMBER_ME_PASSWORD", password.text.trim());
      }

      // Log in user using email and password authentication
      final userCredentials = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Save user records (if necessary)
      await userController.saveUserRecord(userCredentials);

      // Remove loader
      TFullScreenLoader.stopLoading();

      // Redirect to the appropriate screen
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh snap', message: e.toString());
    }
  }

  /// Google sign-in
  Future<void> googleSignIn() async {
    try {
      TFullScreenLoader.openLoadingDialog("Logging you in...", "assets/images/animations/loader-animation.json");

      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(title: 'No Internet', message: 'Please check your internet connection.');
        return;
      }

      // Google authentication
      final userCredentials = await AuthenticationRepository.instance.signInWithGoogle();

      // Save user records
      await userController.saveUserRecord(userCredentials);
      TFullScreenLoader.stopLoading();

      // Redirect to the appropriate screen
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "Oh snap", message: e.toString());
    }
  }
}
