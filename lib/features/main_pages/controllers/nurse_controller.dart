import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../data/services/nurse_services.dart';
import '../../authentication/models/nurse_model.dart';

class NurseController extends GetxController {
  final NurseService _nurseService = NurseService();

  // All nurses loaded from service
  final RxList<NurseModel> allNurses = <NurseModel>[].obs;

  // In NurseController class
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  final searchQuery = ''.obs;
  final selectedFilter = 'All'.obs;

  final TextEditingController searchTextController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    searchTextController.addListener(() {
      updateSearchQuery(searchTextController.text);
    });
    loadAllNurses();
  }

  @override
  void onClose() {
    searchTextController.dispose();
    super.onClose();
  }

  // Update loadAllNurses method
  Future<void> loadAllNurses() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      allNurses.value = await _nurseService.getAllNurses();
    } catch (e) {
      print('Error loading nurses: $e');
      errorMessage.value = 'Failed to load nurses. Please check your connection.';
      // Optionally show a snackbar: Get.snackbar('Error', errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }

  void clearError() {
    errorMessage.value = '';
  }

  // Update search query.
  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  // Update filter.
  void updateFilter(String filter) {
    selectedFilter.value = filter;
  }

  // Computed list based on search and filter.
  List<NurseModel> get filteredNurses {
    List<NurseModel> nurses = List<NurseModel>.from(allNurses);

    // Apply search query filtering on fullName.
    if (searchQuery.value.isNotEmpty) {
      nurses = nurses
          .where((nurse) => nurse.fullName
          .toLowerCase()
          .contains(searchQuery.value.toLowerCase()))
          .toList();
    }

    // Apply filter by specialization if not "All".
    if (selectedFilter.value != 'All') {
      nurses = nurses
          .where((nurse) => nurse.specialization == selectedFilter.value)
          .toList();
    }
    return nurses;
  }
}