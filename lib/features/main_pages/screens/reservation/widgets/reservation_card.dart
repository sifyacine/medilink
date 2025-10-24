import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/nurse_reservation_controller.dart';
import '../../../models/reservation_model.dart';

class ReservationCard extends StatelessWidget {
  final Reservation reservation;

  const ReservationCard({
    super.key,
    required this.reservation,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NurseReservationController());
    final isDark = THelperFunctions.isDarkMode(context);

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Reservation #${reservation.id.substring(0, 8)}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getStatusColor(reservation.status, isDark),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    controller.getStatusText(reservation.status),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: TColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Price and Date
            Row(
              children: [
                _buildInfoItem(
                  context,
                  Iconsax.dollar_circle,
                  '\$${reservation.proposedPrice}',
                ),
                const SizedBox(width: 16),
                _buildInfoItem(
                  context,
                  Iconsax.calendar,
                  _formatDate(reservation.createdAt),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Nurse Notes
            if (reservation.nurseNotes.isNotEmpty) ...[
              Text(
                'Your Notes:',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                reservation.nurseNotes,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
            ],

            // Patient Notes (if available)
            if (reservation.patientNotes != null && reservation.patientNotes!.isNotEmpty) ...[
              Text(
                'Patient Response:',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                reservation.patientNotes!,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
            ],

            // Location Access
            if (reservation.canNurseSeeLocation) ...[
              Row(
                children: [
                  Icon(
                    reservation.locationConfirmedByNurse
                        ? Iconsax.tick_circle
                        : Iconsax.location,
                    size: 16,
                    color: reservation.locationConfirmedByNurse
                        ? Colors.green
                        : TColors.primary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    reservation.locationConfirmedByNurse
                        ? 'Location Confirmed'
                        : 'Location Access Granted',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: reservation.locationConfirmedByNurse
                          ? Colors.green
                          : TColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],

            // Action Buttons based on status
            _buildActionButtons(context, controller),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(BuildContext context, IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: TColors.grey),
        const SizedBox(width: 4),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, NurseReservationController controller) {
    switch (reservation.status) {
      case ReservationStatus.accepted:
        return _buildConfirmLocationButton(context, controller);

      case ReservationStatus.confirmed:
        return _buildStartServiceButton(context, controller);

      case ReservationStatus.inProgress:
        return _buildCompleteServiceButton(context, controller);

      case ReservationStatus.completed:
        return _buildRatingStatus(context);

      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildConfirmLocationButton(BuildContext context, NurseReservationController controller) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => controller.updateReservationStatus(
            reservation.id,
            ReservationStatus.confirmed
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: TColors.primary,
          foregroundColor: TColors.white,
        ),
        child: const Text('Confirm Location & Proceed'),
      ),
    );
  }

  Widget _buildStartServiceButton(BuildContext context, NurseReservationController controller) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => controller.updateReservationStatus(
            reservation.id,
            ReservationStatus.inProgress
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          foregroundColor: TColors.white,
        ),
        child: const Text('Start Service'),
      ),
    );
  }

  Widget _buildCompleteServiceButton(BuildContext context, NurseReservationController controller) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => controller.updateReservationStatus(
            reservation.id,
            ReservationStatus.completed
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: TColors.white,
        ),
        child: const Text('Complete Service'),
      ),
    );
  }

  Widget _buildRatingStatus(BuildContext context) {
    return Row(
      children: [
        Icon(
          reservation.nurseRated ? Iconsax.tick_circle : Iconsax.clock,
          size: 16,
          color: reservation.nurseRated ? Colors.green : TColors.grey,
        ),
        const SizedBox(width: 6),
        Text(
          reservation.nurseRated
              ? 'You rated this service'
              : 'Waiting for your rating',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: reservation.nurseRated ? Colors.green : TColors.grey,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(ReservationStatus status, bool isDark) {
    switch (status) {
      case ReservationStatus.pending:
        return Colors.orange;
      case ReservationStatus.accepted:
        return Colors.blue;
      case ReservationStatus.confirmed:
        return Colors.purple;
      case ReservationStatus.inProgress:
        return Colors.green;
      case ReservationStatus.completed:
        return Colors.green.shade700;
      case ReservationStatus.cancelled:
        return Colors.red;
      case ReservationStatus.rejected:
        return Colors.red.shade700;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}