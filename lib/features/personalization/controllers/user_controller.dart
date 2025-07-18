import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../data/user/user_repository.dart';
import '../../../utils/loaders/loaders.dart';
import '../../authentication/models/patient_model.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  var userEmail = ''.obs;  // Observable property for email

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

        final userRepository = Get.find<UserRepository>();
        await userRepository.saveUserRecord(user);

        userEmail.value = userCredentials.user!.email ?? '';
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

}
