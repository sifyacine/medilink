import 'package:get/get.dart';

class DoctorsSpecialtiesController extends GetxController {
  // Observable bool to track whether the grid is expanded
  final RxBool isExpanded = false.obs;

  void toggleExpanded() {
    isExpanded.value = !isExpanded.value;
  }
}