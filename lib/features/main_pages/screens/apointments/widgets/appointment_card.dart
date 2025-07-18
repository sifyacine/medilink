import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink/utils/constants/colors.dart';
import 'package:medilink/utils/constants/image_strings.dart';
import 'package:medilink/utils/helpers/helper_functions.dart';

import '../../../controllers/planning_controller.dart';
import 'example_appointment_model.dart';

class AppointmentCard extends StatelessWidget {
  final AppointmentItem appointment;
  final VoidCallback? onCancel;
  final VoidCallback? onReschedule;

  const AppointmentCard({
    Key? key,
    required this.appointment,
    this.onCancel,
    this.onReschedule,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PlanningController());
    final Color statusColor = controller.getStatusColor(appointment.state);
    final isDark = THelperFunctions.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        color: isDark? TColors.dark : TColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderRow(statusColor),
              const SizedBox(height: 12),
              _buildDateTimeRow(),
              const SizedBox(height: 12),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderRow(Color statusColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 24,
          backgroundImage: AssetImage(
            appointment.doctorPfpUrl ?? TImages.user,
          ),
        ),
        const SizedBox(width: 12),
        _buildDoctorInfo(),
        const Spacer(),
        _buildStatusIndicator(statusColor),
      ],
    );
  }

  Widget _buildDoctorInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          appointment.doctorName,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          appointment.doctorSpecialty,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusIndicator(Color statusColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        appointment.state,
        style: TextStyle(
          color: statusColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildDateTimeRow() {
    return Row(
      children: [
        const Icon(Icons.calendar_today_outlined, size: 16),
        const SizedBox(width: 4),
        Text(appointment.date),
        const SizedBox(width: 16),
        const Icon(Icons.access_time, size: 16),
        const SizedBox(width: 4),
        Text(appointment.time),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onCancel,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.red,
              side: const BorderSide(color: Colors.red),
            ),
            child: const Text('Cancel'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: onReschedule,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
            ),
            child: const Text('Reprogram'),
          ),
        ),
      ],
    );
  }
}
