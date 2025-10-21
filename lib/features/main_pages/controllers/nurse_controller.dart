import 'package:get/get.dart';
import '../../../data/services/nurse_services.dart';
import '../../authentication/models/nurse_model.dart';

class NurseController extends GetxController {
  final NurseService _nurseService = NurseService();

  // All nurses loaded from service
  final RxList<NurseModel> allNurses = <NurseModel>[].obs;

  // In NurseController class
  final RxBool isLoading = false.obs;

// Update loadAllNurses method
  Future<void> loadAllNurses() async {
    isLoading.value = true;
    try {
      allNurses.value = await _nurseService.getAllNurses();
    } catch (e) {
      print('Error loading nurses: $e');
      // Optionally show a snackbar: Get.snackbar('Error', 'Failed to load nurses');
    } finally {
      isLoading.value = false;
    }
  }

  // Reactive search query and selected filter.
  final searchQuery = ''.obs;
  final selectedFilter = 'All'.obs;

  @override
  void onInit() {
    super.onInit();
    loadAllNurses();
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