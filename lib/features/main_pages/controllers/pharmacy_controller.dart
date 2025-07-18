import 'package:get/get.dart';
import 'package:medilink/data/dummy_data.dart';

import '../models/medicine_model.dart';
import '../models/pharmacy.dart';

class PharmacyController extends GetxController {
  static PharmacyController get instance => Get.find();

  // For carousel indicator
  final carouselCurrentIndex = 0.obs;

  // Use dummy data lists directly
  final RxList<Pharmacy> pharmacies = dummyPharmacy.obs;
  final RxList<Product> products = dummyProduct.obs;

  /// Update the carousel page indicator
  void updatePageIndicator(int index) {
    carouselCurrentIndex.value = index;
  }

  /// Optionally expose getters for clarity
  List<Pharmacy> get allPharmacies => pharmacies;
  List<Product> get allProducts => products;
}
