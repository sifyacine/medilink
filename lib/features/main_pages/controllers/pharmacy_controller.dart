import 'package:get/get.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';



class PharmacyController extends GetxController{
  static PharmacyController get instance => Get.find();

  final carouselCurrentIndex = 0.obs;

  void updatePageIndecator(index){
    carouselCurrentIndex.value = index;
  }

  Future<List<dynamic>> loadMedicines() async {
    String jsonString = await rootBundle.loadString('assets/data/medicines.json');
    return json.decode(jsonString);
  }

}
