import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medilink/features/main_pages/screens/reservation/widgets/reservation_dialog.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/nurse_announcement_controller.dart';
import '../../../models/announcment_model.dart';
import 'mini_map_viewr.dart'; // Import the mini map widget

class AnnouncementDetailsPage extends StatelessWidget {
  const AnnouncementDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NurseAnnouncementController>();
    final announcement = controller.selectedAnnouncement.value;
    final isDark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Announcement Details'),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.heart),
            onPressed: () {
              // Add to favorites functionality
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            _buildHeaderSection(context, announcement, isDark),

            const SizedBox(height: 24),

            // Service Details
            _buildServiceDetailsSection(context, announcement),

            const SizedBox(height: 24),

            // Location Map - ADDED THIS SECTION
            if (announcement.startingPoint != null || announcement.endingPoint != null)
              _buildMapSection(context, announcement),

            if (announcement.startingPoint != null || announcement.endingPoint != null)
              const SizedBox(height: 24),

            // Schedule
            _buildScheduleSection(context, announcement),

            const SizedBox(height: 24),

            // Target Audience
            _buildAudienceSection(context, announcement),

            const SizedBox(height: 24),

            // Additional Notes
            _buildNotesSection(context, announcement),
          ],
        ),
      ),
      bottomNavigationBar: _buildReserveButton(context, controller, announcement),
    );
  }

  Widget _buildHeaderSection(BuildContext context, Announcement announcement, bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? TColors.darkerGrey : TColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Service Request',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: TColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${announcement.city}, ${announcement.state}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Iconsax.eye, size: 16, color: TColors.grey),
              const SizedBox(width: 4),
              Text(
                '${announcement.views} views',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceDetailsSection(BuildContext context, Announcement announcement) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Service Details',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        _buildDetailRow(
          context,
          Iconsax.calendar,
          'Service Type',
          announcement.deplacementType?.toString().split('.').last ?? 'One Time',
        ),
        if (announcement.deplacementFrequency != null)
          _buildDetailRow(
            context,
            Iconsax.repeat,
            'Frequency',
            '${announcement.deplacementFrequency} times',
          ),
      ],
    );
  }

  // NEW: Map Section to show location points
  Widget _buildMapSection(BuildContext context, Announcement announcement) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Service Location',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        MiniMapViewer(
          startingPoint: announcement.startingPoint,
          endingPoint: announcement.endingPoint,
        ),
        const SizedBox(height: 8),
        if (announcement.startingPoint != null && announcement.endingPoint != null) ...[
          _buildLocationDetailRow('Starting Point', announcement.startingPoint!),
          _buildLocationDetailRow('Ending Point', announcement.endingPoint!),
        ] else if (announcement.startingPoint != null)
          _buildLocationDetailRow('Location', announcement.startingPoint!),
      ],
    );
  }

  Widget _buildLocationDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: TColors.darkGrey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleSection(BuildContext context, Announcement announcement) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Schedule',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        _buildDetailRow(
          context,
          Iconsax.calendar_1,
          'Start Date',
          '${announcement.startDate.day}/${announcement.startDate.month}/${announcement.startDate.year}',
        ),
        if (announcement.endDate != null)
          _buildDetailRow(
            context,
            Iconsax.calendar_2,
            'End Date',
            '${announcement.endDate!.day}/${announcement.endDate!.month}/${announcement.endDate!.year}',
          ),
        _buildDetailRow(
          context,
          Iconsax.clock,
          'Time',
          '${announcement.startTime.format(context)} - ${announcement.endTime.format(context)}',
        ),
      ],
    );
  }

  Widget _buildAudienceSection(BuildContext context, Announcement announcement) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Target Audience',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Chip(
          label: Text(announcement.targetAudience),
          backgroundColor: TColors.primary.withOpacity(0.1),
        ),
        if (announcement.minAge != null || announcement.maxAge != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              'Age Range: ${announcement.minAge ?? 'Any'} - ${announcement.maxAge ?? 'Any'}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
      ],
    );
  }

  Widget _buildNotesSection(BuildContext context, Announcement announcement) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Additional Notes',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: THelperFunctions.isDarkMode(context)
                ? TColors.darkerGrey
                : TColors.light,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            announcement.additionalNotes.isEmpty
                ? 'No additional notes provided'
                : announcement.additionalNotes,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(BuildContext context, IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: TColors.primary),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: Text(title, style: Theme.of(context).textTheme.bodyMedium),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReserveButton(BuildContext context, NurseAnnouncementController controller, Announcement announcement) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: THelperFunctions.isDarkMode(context) ? TColors.dark : TColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () => _showReservationDialog(context, controller, announcement),
        style: ElevatedButton.styleFrom(
          backgroundColor: TColors.primary,
          foregroundColor: TColors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2, color: TColors.white),
            );
          }
          return const Text('Send Reservation Request');
        }),
      ),
    );
  }

  void _showReservationDialog(BuildContext context, NurseAnnouncementController controller, Announcement announcement) {
    showDialog(
      context: context,
      builder: (context) => ReservationDialog(
        announcement: announcement,
        onReserve: (price, notes) {
          controller.createReservation(
            announcementId: announcement.uid,
            patientId: announcement.publisherId,
            proposedPrice: price,
            nurseNotes: notes,
          );
        },
      ),
    );
  }
}