import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/repositories/authentication_repository.dart';
import '../../../data/user/user_repository.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/loaders/loaders.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../authentication/models/nurse_model.dart';
import '../../authentication/models/patient_model.dart';
import '../../authentication/screens/login/login_screen.dart';
import '../screens/profile/widgets/reauthenticate_page.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final user = UserModel.empty().obs;
  final nurse = NurseModel.empty().obs; // Add nurse observable
  final profileLoading = false.obs;
  final imageUpLoading = false.obs;
  final userData = Rxn<Map<String, dynamic>>();
  final _storage = GetStorage();

  // Add role detection
  final currentUserRole = ''.obs; // 'patient' or 'nurse'

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
    determineUserRoleAndFetch();
  }

  // Determine if user is patient or nurse and fetch appropriate data
  Future<void> determineUserRoleAndFetch() async {
    try {
      profileLoading.value = true;

      // Fetch user data from the same repository
      final userData = await UserRepository.instance.fetchUserDetails();

      // Check the role field to determine if it's a patient or nurse
      if (userData.role == 'nurse') {
        // Convert UserModel to NurseModel
        final nurseData = _convertToNurseModel(userData);
        this.nurse(nurseData);
        currentUserRole.value = 'nurse';
        print("User is nurse: $nurseData");
      } else {
        // It's a patient
        this.user(userData);
        currentUserRole.value = 'patient';
        print("User is patient: $userData");
      }
    } catch (e) {
      print("Error determining user role: $e");
    } finally {
      profileLoading.value = false;
    }
  }

  // Convert UserModel to NurseModel
  NurseModel _convertToNurseModel(UserModel user) {
    return NurseModel(
      id: user.id,
      firstName: user.firstName,
      lastName: user.lastName,
      username: user.username,
      email: user.email,
      phoneNumber: user.phoneNumber,
      profilePicUrl: user.profilePicUrl,
      dateOfBirth: user.dateOfBirth,
      city: user.city,
      state: user.state,
      address: user.address,
      role: user.role ?? 'nurse',
      // Nurse-specific fields can be set to null/default
      licenseNumber: null,
      specialization: null,
      workplace: null,
      emergencyContact: null,
      isVerified: false,
      isActive: true,
      certifications: null,
      languages: null,
      bio: null,
      rating: null,
      reviewCount: 0,
      availability: null,
      servicesOffered: null,
    );
  }

  // Load user data from GetStorage if available
  void _loadUserData() {
    final savedData = _storage.read<Map<String, dynamic>>('userData');
    if (savedData != null) {
      userData.value = savedData;
    }
  }

  final verifyEmail = TextEditingController();
  final hidePassword = true.obs;
  final verifyPassword = TextEditingController();
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  // Get current user ID based on role
  String get currentUserId {
    if (currentUserRole.value == 'nurse') {
      return nurse.value.id;
    } else {
      return user.value.id;
    }
  }

  // Get current user name based on role
  String get currentUserName {
    if (currentUserRole.value == 'nurse') {
      return nurse.value.fullName;
    } else {
      return user.value.fullName;
    }
  }

  // Get current user phone based on role
  String get currentUserPhone {
    if (currentUserRole.value == 'nurse') {
      return nurse.value.formattedPhoneNo;
    } else {
      return user.value.formattedPhoneNo;
    }
  }

  // Get current user for reservation (returns NurseModel if nurse, null if patient)
  NurseModel? get currentNurseForReservation {
    if (currentUserRole.value == 'nurse') {
      return nurse.value;
    }
    return null;
  }

  // Check if current user is a nurse
  bool get isNurse => currentUserRole.value == 'nurse';

  // Check if current user is a patient
  bool get isPatient => currentUserRole.value == 'patient';

  // Get user email (common for both)
  String get currentUserEmail {
    if (currentUserRole.value == 'nurse') {
      return nurse.value.email;
    } else {
      return user.value.email;
    }
  }

  // Existing methods remain but now work based on role
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await UserRepository.instance.fetchUserDetails();

      if (user.role == 'nurse') {
        this.nurse(_convertToNurseModel(user));
        currentUserRole.value = 'nurse';
      } else {
        this.user(user);
        currentUserRole.value = 'patient';
      }

      print("user is fetched: ${currentUserRole.value}");
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
      ),
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

  // Save user Record from any Registration provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      // First Update Rx User and then check if user data is already stored. If not store new data
      await fetchUserRecord();

      // If no record already stored.
      if (user.value.id.isEmpty && nurse.value.id.isEmpty) {
        if (userCredentials != null) {
          // Convert Name to First and Last Name
          final nameParts = UserModel.nameParts(userCredentials.user!.displayName ?? '');
          final username = UserModel.generateUsername(userCredentials.user!.displayName ?? '');

          // Map Data - This creates a patient by default
          // You might want to modify this based on your registration flow
          final user = UserModel(
            id: userCredentials.user!.uid,
            firstName: nameParts[0],
            lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
            username: username,
            email: userCredentials.user!.email ?? '',
            phoneNumber: userCredentials.user!.phoneNumber ?? '',
            profilePicUrl: userCredentials.user!.photoURL ?? '',
            role: 'patient', // Default to patient
          );

          // Save user data
          final userRepository = Get.put(UserRepository());
          await userRepository.saveUserRecord(user);
        }
      }
    } catch (e) {
      TLoaders.warningSnackBar(
        title: 'Data not saved',
        message: 'Something went wrong while saving your information. You can re-save your data in your Profile.',
      );
    }
  }

  /// Upload Profile Image
  uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 512,
        maxWidth: 512,
      );

      if (image != null) {
        imageUpLoading.value = true;
        // Upload Image
        final userRepository = Get.put(UserRepository());
        final imageUrl = await userRepository.uploadImage('Users/Images/Profile/', image);

        // Update User Image Record
        Map<String, dynamic> json = {'ProfilePicture': imageUrl};
        await userRepository.updateSingleField(json);

        // Update the appropriate model based on role
        if (currentUserRole.value == 'nurse') {
          nurse.value.profilePicUrl = imageUrl;
          nurse.refresh();
        } else {
          user.value.profilePicUrl = imageUrl;
          user.refresh();
        }

        TLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your Profile Image has been updated!',
        );
      }
    } catch (e) {
      TLoaders.errorSnackBar(
        title: 'OhSnap',
        message: 'Something went wrong: $e',
      );
    } finally {
      imageUpLoading.value = false;
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