import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:midilink/common/widgets/appbar/appbar.dart';
import 'package:midilink/features/main_pages/controllers/planning_controller.dart';
import 'package:midilink/features/main_pages/screens/apointments/widgets/appointment_card.dart';
import 'package:midilink/features/main_pages/screens/apointments/widgets/example_appointment_model.dart';
import '../../../../common/widgets/custom_shapes/containers/animated_container_tabbar.dart';
import '../../../../common/widgets/icon/notification_icon_button.dart';

class PlanningScreen extends StatelessWidget {
  const PlanningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PlanningController controller = Get.put(PlanningController());

    return Scaffold(
      appBar: TAppBar(
        title: const Text("Planning"),
        actions: [
          NotificationIconButton(notificationCount: 5, onPressed: (){},),
        ],
      ),
      body: Column(
        children: [
          // Tab bar to switch between appointment categories.
          Obx(
                () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: SelectableOption(
                      title: 'Future',
                      isSelected: controller.currentTabIndex.value == 0,
                      onTap: () => controller.currentTabIndex.value = 0,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: SelectableOption(
                      title: 'Finished',
                      isSelected: controller.currentTabIndex.value == 1,
                      onTap: () => controller.currentTabIndex.value = 1,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: SelectableOption(
                      title: 'Canceled',
                      isSelected: controller.currentTabIndex.value == 2,
                      onTap: () => controller.currentTabIndex.value = 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Appointment list that updates based on the selected tab.
          Expanded(
            child: Obx(() {
              // Filter appointments based on currentTabIndex:
              // 0: Future appointments (not finished and not canceled)
              // 1: Finished appointments
              // 2: Canceled appointments
              List<AppointmentItem> filteredAppointments;
              switch (controller.currentTabIndex.value) {
                case 1:
                  filteredAppointments = controller.allAppointments.where((a) => a.isFinished).toList();
                  break;
                case 2:
                  filteredAppointments = controller.allAppointments.where((a) => a.isCanceled).toList();
                  break;
                case 0:
                default:
                  filteredAppointments = controller.allAppointments.where((a) => !a.isFinished && !a.isCanceled).toList();
              }

              if (filteredAppointments.isEmpty) {
                return const Center(child: Text("No appointments found."));
              }

              return ListView.builder(
                itemCount: filteredAppointments.length,
                itemBuilder: (context, index) {
                  final appointment = filteredAppointments[index];
                  return AppointmentCard(
                    appointment: appointment,
                    onCancel: () {
                      // Handle cancel logic here.
                    },
                    onReschedule: () {
                      // Handle reschedule logic here.
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
