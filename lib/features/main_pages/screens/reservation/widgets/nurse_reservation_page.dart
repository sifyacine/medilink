import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/nurse_reservation_controller.dart';
import '../../../models/reservation_model.dart';
import '../widgets/reservation_card.dart';

class NurseReservationsPage extends StatelessWidget {
  const NurseReservationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NurseReservationController());

    return Column(
      children: [
        // Status Filter Chips
        SizedBox(
          height: 60,
          child: Obx(() => ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _buildStatusChip(context, 'All', ReservationStatus.pending, controller),
              _buildStatusChip(context, 'Pending', ReservationStatus.pending, controller),
              _buildStatusChip(context, 'Accepted', ReservationStatus.accepted, controller),
              _buildStatusChip(context, 'Confirmed', ReservationStatus.confirmed, controller),
              _buildStatusChip(context, 'In Progress', ReservationStatus.inProgress, controller),
              _buildStatusChip(context, 'Completed', ReservationStatus.completed, controller),
            ],
          )),
        ),

        // Reservations List
        Obx(() {
          final filteredReservations = controller.filteredReservations;

          if (controller.isLoading.value) {
            return const Expanded(
              child: Center(child: CircularProgressIndicator()),
            );
          }

          if (filteredReservations.isEmpty) {
            return Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Iconsax.note_remove, size: 64, color: TColors.grey),
                    const SizedBox(height: 16),
                    Text(
                      controller.selectedStatus.value == ReservationStatus.pending
                          ? 'No reservations found'
                          : 'No ${_getStatusText(controller.selectedStatus.value)} reservations',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your reservation requests will appear here',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }

          return Expanded(
            child: RefreshIndicator(
              onRefresh: () => controller.loadReservations(),
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: filteredReservations.length,
                itemBuilder: (context, index) {
                  final reservation = filteredReservations[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: ReservationCard(reservation: reservation),
                  );
                },
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildStatusChip(
      BuildContext context,
      String text,
      ReservationStatus status,
      NurseReservationController controller,
      ) {
    final isSelected = controller.selectedStatus.value == status;
    final isDark = THelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () => controller.setSelectedStatus(status),
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? TColors.primary : Colors.transparent,
          border: Border.all(
            color: isSelected ? TColors.primary : TColors.grey,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: isSelected
                ? TColors.white
                : isDark ? TColors.white : TColors.dark,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  String _getStatusText(ReservationStatus status) {
    switch (status) {
      case ReservationStatus.pending:
        return 'pending';
      case ReservationStatus.accepted:
        return 'accepted';
      case ReservationStatus.confirmed:
        return 'confirmed';
      case ReservationStatus.inProgress:
        return 'in progress';
      case ReservationStatus.completed:
        return 'completed';
      case ReservationStatus.cancelled:
        return 'cancelled';
      case ReservationStatus.rejected:
        return 'rejected';
    }
  }
}