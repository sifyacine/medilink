import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../../data/user/user_repository.dart';
import '../../../features/personalization/controllers/user_controller.dart';
import '../../../utils/constants/image_strings.dart';

import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';

class UpdatePersonalInfoController extends GetxController {
  static UpdatePersonalInfoController get instance => Get.find();

  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());

  // Form Key
  final personalInfoFormKey = GlobalKey<FormState>();

  // Text Fields
  final address = TextEditingController();
  final role = TextEditingController();

  // Dropdown fields
  var gender = ''.obs;
  var bloodType = ''.obs;
  var state = ''.obs;
  var city = ''.obs;
  var dateOfBirth = Rxn<DateTime>();
  final networkManager = Get.put(NetworkManager());

  // Dropdown options
  final bloodTypeOptions = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  final genderOptions = ['Male', 'Female', 'Other'];

  var states = <String>[].obs;
  var cities = <String>[].obs;

  // Store the full data for processing
  var locationData = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    initializeUserData();
    loadStatesAndCities();
    super.onInit();
  }

  void initializeUserData() {
    final user = userController.user.value;
    address.text = user.address ?? '';
    role.text = user.role ?? '';
    gender.value = user.gender ?? '';
    bloodType.value = user.bloodType ?? '';
    state.value = user.state ?? '';
    city.value = user.city ?? '';
    dateOfBirth.value = user.dateOfBirth;
  }

  Future<void> loadStatesAndCities() async {
    try {
      final data = await rootBundle.loadString('assets/data/states_cities.json');
      final List<dynamic> jsonResult = json.decode(data);

      // Store the full data
      locationData.assignAll(jsonResult.cast<Map<String, dynamic>>());

      // Extract unique wilaya names for states dropdown
      final Set<String> uniqueStates = {};
      for (var item in jsonResult) {
        uniqueStates.add(item['wilaya_name'].toString());
      }
      states.assignAll(uniqueStates.toList()..sort());

      // If user already has a state selected, load its cities
      if (state.value.isNotEmpty) {
        loadCitiesForState(state.value);
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Error', message: 'Failed to load states and cities.');
    }
  }

  void onStateSelected(String selectedState) {
    state.value = selectedState;
    city.value = ''; // Reset city when state changes
    loadCitiesForState(selectedState);
  }

  void loadCitiesForState(String selectedState) {
    try {
      // Filter communes by selected wilaya
      final List<String> stateCities = locationData
          .where((item) => item['wilaya_name'] == selectedState)
          .map((item) => item['commune_name'].toString())
          .toSet() // Remove duplicates
          .toList();

      stateCities.sort(); // Sort alphabetically
      cities.assignAll(stateCities);
    } catch (e) {
      cities.clear();
      TLoaders.errorSnackBar(title: 'Error', message: 'Failed to load cities for selected state.');
    }
  }

  // Helper method to get wilaya code if needed
  String? getWilayaCode(String wilayaName) {
    try {
      final item = locationData.firstWhere(
            (item) => item['wilaya_name'] == wilayaName,
      );
      return item['wilaya_code']?.toString();
    } catch (e) {
      return null;
    }
  }

  // Helper method to get daira name if needed
  String? getDairaName(String wilayaName, String communeName) {
    try {
      final item = locationData.firstWhere(
            (item) => item['wilaya_name'] == wilayaName &&
            item['commune_name'] == communeName,
      );
      return item['daira_name']?.toString();
    } catch (e) {
      return null;
    }
  }

  Future<void> updatePersonalInfo() async {
    try {
      TFullScreenLoader.openLoadingDialog(
        'Updating personal information...',
        TImages.docerAnimation,
      );

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (!personalInfoFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      final data = {
        'Gender': gender.value,
        'Address': address.text.trim(),
        'BloodType': bloodType.value,
        'DateOfBirth': dateOfBirth.value?.toIso8601String(),
        'State': state.value,
        'City': city.value,
        'Role': role.text.trim(),
        // Optional: Add wilaya code if your backend needs it
        'WilayaCode': getWilayaCode(state.value),
        // Optional: Add daira name if your backend needs it
        'DairaName': getDairaName(state.value, city.value),
      };

      await userRepository.updateSingleField(data);

      // Update local user state
      userController.user.update((user) {
        if (user != null) {
          user.gender = gender.value;
          user.address = address.text.trim();
          user.bloodType = bloodType.value;
          user.dateOfBirth = dateOfBirth.value;
          user.state = state.value;
          user.city = city.value;
          user.role = role.text.trim();
        }
      });

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
        title: 'Success',
        message: 'Personal information updated successfully.',
      );

      Get.back();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }
}