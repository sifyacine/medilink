import 'package:get/get.dart';

class AppointmentController extends GetxController {
  // Doctor Information
  var doctorName = 'Dr. Mansouri'.obs;
  var specialization = 'Cardiologue'.obs;
  var rating = 4.7.obs;
  var distance = '800m'.obs;

  // Appointment Information
  var date = 'Mercredi 23 janv 2025 | 10:00 AM'.obs;
  var reason = 'Douleur thoracique'.obs;

  // Payment Details
  var consultationFee = 2500.0.obs;
  var adminFee = 1500.0.obs;
  var additionalDiscount = 0.0.obs;

  // Payment Method
  var paymentMethod = 'Visa **** 1234'.obs;

  // Methods to edit or book appointment
  void editDate() {
    // Implement edit date logic
    print('Editing date...');
  }

  void editReason() {
    // Implement edit reason logic
    print('Editing reason...');
  }

  void editPaymentMethod() {
    // Implement edit payment method logic
    print('Editing payment method...');
  }

  void bookAppointment() {
    // Implement booking logic
    print('Appointment booked!');
  }
}
