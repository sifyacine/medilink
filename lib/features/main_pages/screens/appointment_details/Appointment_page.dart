import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink/features/main_pages/screens/appointment_details/widgets/doctor_info_card.dart';
import 'package:medilink/features/main_pages/screens/appointment_details/widgets/editable_row_widget.dart';
import 'package:medilink/features/main_pages/screens/appointment_details/widgets/payment_detail_section.dart';
import 'package:medilink/features/main_pages/screens/appointment_details/widgets/payment_method_section.dart';
import '../../controllers/appointment_controller.dart';

class AppointmentPage extends StatelessWidget {
  // Register the controller
  final controller = Get.put(AppointmentController());

  AppointmentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Doctor Info Card
            DoctorInfoCard(controller: controller),
            const SizedBox(height: 16),

            // Date row
            EditableRowWidget(
              title: 'Date',
              value: () => controller.date.value,
              onEdit: controller.editDate,
            ),
            const SizedBox(height: 16),

            // Reason row
            EditableRowWidget(
              title: 'Reason',
              value: () => controller.reason.value,
              onEdit: controller.editReason,
            ),
            const SizedBox(height: 16),

            // Payment Detail Section
            PaymentDetailSection(controller: controller),
            const SizedBox(height: 16),

            // Payment Method Section
            PaymentMethodSection(controller: controller),
            const SizedBox(height: 16),

            // Final Total
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Total',
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Obx(() {
                // Compute total inside the Obx so its dependencies are tracked
                final total = controller.consultationFee.value +
                    controller.adminFee.value -
                    controller.additionalDiscount.value;
                return Text(
                  '${total.toStringAsFixed(2)} DA',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                );
              }),
            ),
            const SizedBox(height: 24),

            // Booking Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.bookAppointment,
                child: const Text('Book now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
