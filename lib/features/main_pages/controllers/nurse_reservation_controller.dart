import 'package:get/get.dart';

import '../../../data/services/reservation_service.dart';
import '../models/reservation_model.dart';


class NurseReservationController extends GetxController {
  static NurseReservationController get instance => Get.find();

  final ReservationService _reservationService = ReservationService();
  var reservations = <Reservation>[].obs;
  var isLoading = false.obs;
  var selectedStatus = ReservationStatus.pending.obs;

  @override
  void onInit() {
    super.onInit();
    loadReservations();
  }

  Future<void> loadReservations() async {
    try {
      isLoading(true);
      // This would need the nurse ID - you might get it from auth
      final String nurseId = 'nurse123'; // Get from your auth system - placeholder
      final Stream<List<Reservation>> loadedReservations =
      await _reservationService.getNurseReservations(nurseId);
      reservations.assignAll(loadedReservations as Iterable<Reservation>);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load reservations: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateReservationStatus(
      String reservationId,
      ReservationStatus status
      ) async {
    try {
      isLoading(true);

      switch (status) {
        case ReservationStatus.confirmed:
          await _reservationService.confirmLocation(reservationId);
          break;
        case ReservationStatus.inProgress:
          await _reservationService.startService(reservationId);
          break;
        case ReservationStatus.completed:
          await _reservationService.completeService(reservationId);
          break;
        default:
          break;
      }

      await loadReservations(); // Refresh the list
      Get.snackbar('Success', 'Reservation status updated');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update reservation: $e');
    } finally {
      isLoading(false);
    }
  }

  List<Reservation> get filteredReservations {
    if (selectedStatus.value == ReservationStatus.pending) {
      return reservations;
    }
    return reservations.where((res) => res.status == selectedStatus.value).toList();
  }

  String getStatusText(ReservationStatus status) {
    switch (status) {
      case ReservationStatus.pending:
        return 'Pending';
      case ReservationStatus.accepted:
        return 'Accepted';
      case ReservationStatus.confirmed:
        return 'Confirmed';
      case ReservationStatus.inProgress:
        return 'In Progress';
      case ReservationStatus.completed:
        return 'Completed';
      case ReservationStatus.cancelled:
        return 'Cancelled';
      case ReservationStatus.rejected:
        return 'Rejected';
    }
  }

  void setSelectedStatus(ReservationStatus status) {
    selectedStatus.value = status;
  }
}