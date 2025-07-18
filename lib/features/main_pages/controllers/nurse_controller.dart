import 'package:get/get.dart';
import '../../../data/dummy_data.dart';
import '../models/nurse_model.dart';



class NurseController extends GetxController {
  // All nurses (dummy data)
  final allNurses = dummyNurses.obs;

  // Reactive search query and selected filter.
  final searchQuery = ''.obs;
  final selectedFilter = 'All'.obs;

  // Update search query.
  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  // Update filter.
  void updateFilter(String filter) {
    selectedFilter.value = filter;
  }

  // Computed list based on search and filter.
  List<Nurse> get filteredNurses {
    List<Nurse> nurses = allNurses;

    // Apply search query filtering.
    if (searchQuery.value.isNotEmpty) {
      nurses = nurses
          .where((nurse) => nurse.fullName
          .toLowerCase()
          .contains(searchQuery.value.toLowerCase()))
          .toList();
    }

    // Apply filter by specialty if not "All".
    if (selectedFilter.value != 'All') {
      nurses = nurses
          .where((nurse) => nurse.nursingSpecialties
          .contains(selectedFilter.value))
          .toList();
    }
    return nurses;
  }
}
