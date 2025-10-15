import 'package:get/get.dart';
import '../model/activity_model.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  /// --- Variables ---
  final isLoading = true.obs; // To show a loader while fetching data

  // User-specific information
  final RxString userName = 'Noor'.obs;
  final RxInt notificationCount = 3.obs;

  // Data from our "backend"
  final RxInt todayPatientCount = 0.obs;
  final Rx<ActiveVisitModel?> activeVisit = Rx<ActiveVisitModel?>(null);
  final RxList<RecentActivityModel> recentActivities = <RecentActivityModel>[]
      .obs;

  /// --- Lifecycle ---
  @override
  void onInit() {
    super.onInit();
    fetchHomePageData(); // Fetch data when the controller is initialized
  }

  /// --- Data Fetching ---
  Future<void> fetchHomePageData() async {
    try {
      // Start loading
      isLoading.value = true;

      // Simulate a delay for fetching data from an API/repository
      await Future.delayed(const Duration(seconds: 1));

      // --- Mock Data ---
      // In a real app, you would get this data from a repository layer
      // e.g., final data = await _homeRepository.getDashboardData();

      todayPatientCount.value = 8;

      activeVisit.value = ActiveVisitModel(
        id: 'visit123',
        patientName: 'Eleanor',
        address: '123 Maple Street, anyTown',
        imageUrl: 'assets/images/users/eleanor.png', // Placeholder image path
      );

      final activitiesData = [
        RecentActivityModel(
            id: 'act001',
            description: 'The appointment for patient Ahmed Ali has been rescheduled to July 4 at 10:00 AM.',
            type: ActivityType.reschedule,
            timestamp: DateTime.now().subtract(const Duration(hours: 2))),
        RecentActivityModel(
            id: 'act002',
            description: 'An emergency was reported for patient Youssef Hassan.',
            type: ActivityType.emergency,
            timestamp: DateTime.now().subtract(const Duration(hours: 5))),
        RecentActivityModel(
            id: 'act003',
            description: 'New request: Visit patient Laila Mahmoud on July 5.',
            type: ActivityType.newRequest,
            timestamp: DateTime.now().subtract(const Duration(days: 1))),
      ];
      recentActivities.assignAll(activitiesData);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load home data: ${e.toString()}');
    } finally {
      // Stop loading
      isLoading.value = false;
    }
  }
}
