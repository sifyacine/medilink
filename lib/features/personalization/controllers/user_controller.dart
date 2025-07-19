import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/repositories/authentication_repository.dart';
import '../../../data/user/user_repository.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/loaders/loaders.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../authentication/models/patient_model.dart';
import '../../authentication/screens/login/login_screen.dart';
import '../screens/profile/widgets/reauthenticate_page.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final user = UserModel.empty().obs;
  final profileLoading = false.obs;

  final verifyEmail = TextEditingController();
  final hidePassword = true.obs;
  final verifyPassword = TextEditingController();
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();


  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await UserRepository.instance.fetchUserDetails();
      this.user(user);
      print("user is fetrched");
      profileLoading.value = false;
    } catch (e) {
      print("error: $e");
      user(UserModel.empty());
    } finally{
      profileLoading.value = false;
    }
  }
  /// Delete Account Warning
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(TSizes.md),
      title: 'Delete Account',
      middleText:
      'Are you sure you want to delete your account permanently? This action is not reversible and all of your data will be removed permanently.',
      confirm: ElevatedButton(
        onPressed: () async => deleteUserAccount(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          side: const BorderSide(color: Colors.red),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: TSizes.lg),
          child: Text('Delete'),
        ),
      ), // ElevatedButton
      cancel: OutlinedButton(
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        child: const Text('Cancel'),
      ),
    );
  }

  /// Delete User Account
  void deleteUserAccount() async {
    try {
      TFullScreenLoader.openLoadingDialog('Processing', TImages.docerAnimation);

      /// First re-authenticate user
      final auth = AuthenticationRepository.instance;
      final provider = auth.authUser!.providerData.map((e) => e.providerId).first;

      if (provider.isNotEmpty) {
        /// Re-verify Auth Email
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          TFullScreenLoader.stopLoading();
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          TFullScreenLoader.stopLoading();
          Get.to(() => ReAuthLoginForm());
        }
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }


  // save user record
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      if (userCredentials != null && userCredentials.user != null) {
        final user = UserModel(
          id: userCredentials.user!.uid,
          firstName: UserModel.nameParts(userCredentials.user!.displayName ?? "")[0],
          lastName: UserModel.nameParts(userCredentials.user!.displayName ?? "").sublist(1).join(' '),
          username: UserModel.generateUsername(userCredentials.user!.displayName ?? ""),
          email: userCredentials.user!.email ?? '',
          phoneNumber: userCredentials.user!.phoneNumber ?? '',
        );

        final userRepository = Get.put(UserRepository());
        await userRepository.saveUserRecord(user);

        TLoaders.successSnackBar(
          title: "Data is saved",
          message: "data have been saved successfully",
        );
      } else {
        print("UserCredentials or user is null");
      }
    } catch (e, stackTrace) {
      print("Error saving user record: $e");
      print("Stack trace: $stackTrace");
      TLoaders.warningSnackBar(
        title: "Data not saved",
        message: "Something went wrong while saving your information.",
      );
    }
  }

  /// --- RE-AUTHENTICATE before deleting
  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      TFullScreenLoader.openLoadingDialog('Processing', TImages.docerAnimation);

      // Check Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (!reAuthFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance.reAuthenticateWithEmailAndPassword(
        verifyEmail.text.trim(),
        verifyPassword.text.trim(),
      );

      await AuthenticationRepository.instance.deleteAccount();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

}
