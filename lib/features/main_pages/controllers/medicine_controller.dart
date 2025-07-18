import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';

// MedicinesController.dart
class ProductsController extends GetxController {
  Future<List<dynamic>> loadMedicines() async {
    String jsonString = await rootBundle.loadString('assets/data/medicines.json');
    return json.decode(jsonString);
  }
}
