import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../data/services/announcement_services.dart';
import '../../../data/services/reservation_service.dart';
import '../../authentication/models/nurse_model.dart';
import '../models/announcment_model.dart';
import '../models/reservation_model.dart';


class NurseAnnouncementController extends GetxController {
  static NurseAnnouncementController get instance => Get.find();

  // Services
  final AnnouncementService _announcementService = AnnouncementService();
  final ReservationService _reservationService = ReservationService();

  // Observables
  var announcements = <Announcement>[].obs;
  var reservations = <Reservation>[].obs;
  var selectedAnnouncement = Announcement.empty().obs;
  var isLoading = false.obs;
  var selectedTabIndex = 0.obs; // 0: Announcements, 1: My Requests

  // Filtering
  var selectedCity = ''.obs;
  var selectedState = ''.obs;
  var selectedAudience = ''.obs;
  var searchQuery = ''.obs;

  // Nurse data
  final Rx<NurseModel> currentNurse = NurseModel.empty().obs;

  @override
  void onInit() {
    super.onInit();
    loadCurrentNurse();
    loadAnnouncements();
    loadNurseReservations();
  }

  void loadCurrentNurse() {
    // Replace with your actual nurse loading logic
    // This could come from auth controller or local storage
    currentNurse.value = NurseModel.empty(); // Placeholder
  }

  Future<void> loadAnnouncements() async {
    try {
      isLoading(true);
      final List<Announcement> loadedAnnouncements =
      await _announcementService.getActiveAnnouncements();
      announcements.assignAll(loadedAnnouncements);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load announcements: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> loadNurseReservations() async {
    try {
      final Stream<List<Reservation>> loadedReservations =
      await _reservationService.getNurseReservations(currentNurse.value.id);
      reservations.assignAll(loadedReservations as Iterable<Reservation>);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load reservations: $e');
    }
  }

  Future<void> searchAnnouncements() async {
    try {
      isLoading(true);
      final List<Announcement> results =
      await _announcementService.searchAnnouncements(
        keyword: searchQuery.value.isEmpty ? null : searchQuery.value,
        city: selectedCity.value.isEmpty ? null : selectedCity.value,
        state: selectedState.value.isEmpty ? null : selectedState.value,
        targetAudience: selectedAudience.value.isEmpty ? null : selectedAudience.value,
      );
      announcements.assignAll(results);
    } catch (e) {
      Get.snackbar('Error', 'Failed to search announcements: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> createReservation({
    required String announcementId,
    required String patientId,
    required double proposedPrice,
    required String nurseNotes,
  }) async {
    try {
      isLoading(true);
      await _reservationService.createOffer(
        announcementId: announcementId,
        patientId: patientId,
        nurseId: currentNurse.value.id,
        proposedPrice: proposedPrice,
        nurseNotes: nurseNotes,
      );

      Get.back(); // Close the reservation dialog
      Get.snackbar('Success', 'Reservation request sent successfully!');
      loadNurseReservations(); // Refresh the list
    } catch (e) {
      Get.snackbar('Error', 'Failed to create reservation: $e');
    } finally {
      isLoading(false);
    }
  }

  void setSelectedAnnouncement(Announcement announcement) {
    selectedAnnouncement.value = announcement;
  }

  void clearFilters() {
    selectedCity.value = '';
    selectedState.value = '';
    selectedAudience.value = '';
    searchQuery.value = '';
    loadAnnouncements();
  }

  List<Reservation> get reservationsByStatus {
    if (selectedTabIndex.value == 0) return reservations;

    final statusMap = {
      1: ReservationStatus.pending,
      2: ReservationStatus.accepted,
      3: ReservationStatus.confirmed,
      4: ReservationStatus.inProgress,
      5: ReservationStatus.completed,
    };

    final status = statusMap[selectedTabIndex.value];
    return reservations.where((res) => res.status == status).toList();
  }
}