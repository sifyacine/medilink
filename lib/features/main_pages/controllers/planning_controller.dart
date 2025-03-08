import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:midilink/features/main_pages/screens/apointments/widgets/example_appointment_model.dart';
import 'package:midilink/utils/constants/image_strings.dart';

class PlanningController extends GetxController {
  /// Current tab index (0 = Future, 1 = Finished, 2 = Canceled)
  var currentTabIndex = 0.obs;

  /// Mock data for all appointments
  final List<AppointmentItem> allAppointments = [
    AppointmentItem(
      doctorName: "Dr. Sarah Johnson",
      doctorSpecialty: "Cardiologist",
      doctorPfpUrl: TImages.user4,
      patientName: "John Doe",
      time: "09:00 AM",
      date: "2025-08-15",
      state: "Upcoming",
      isFinished: false,
      isCanceled: false,
    ),
    AppointmentItem(
      doctorName: "Dr. Michael Chen",
      doctorSpecialty: "Dermatologist",
      doctorPfpUrl: TImages.user3,
      patientName: "Jane Smith",
      time: "02:30 PM",
      date: "2025-08-10",
      state: "Completed",
      isFinished: true,
      isCanceled: false,
    ),
    AppointmentItem(
      doctorName: "Dr. Emily Rodriguez",
      doctorSpecialty: "Pediatrician",
      doctorPfpUrl: TImages.user2,
      patientName: "Alice Johnson",
      time: "11:15 AM",
      date: "2025-08-12",
      state: "Canceled",
      isFinished: false,
      isCanceled: true,
    ),
    AppointmentItem(
      doctorName: "Dr. David Kim",
      doctorSpecialty: "Orthopedic Surgeon",
      doctorPfpUrl: TImages.user1,
      patientName: "Robert Brown",
      time: "04:45 PM",
      date: "2025-08-18",
      state: "Confirmed",
      isFinished: false,
      isCanceled: false,
    ),
  ];

  /// Returns a color based on the appointment status.
  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return Colors.green;
      case 'canceled':
        return Colors.red;
      case 'completed':
        return Colors.blue;
      default:
        return Colors.orange;
    }
  }
}
