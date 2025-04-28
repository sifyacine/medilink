// clinic_controller.dart
import 'package:get/get.dart';

import '../../../data/dummy_data.dart';
import '../models/clinic_model.dart';

class ClinicController extends GetxController {
  // Create an observable list of clinics
  var clinics = <Clinic>[].obs;

  @override
  void onInit() {
    // Load your dummy clinics data here
    clinics.value = dummyClinics;
    super.onInit();
  }
}
