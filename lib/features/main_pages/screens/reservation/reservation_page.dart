import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink/features/main_pages/screens/reservation/widgets/nurse_announcement_list.dart';
import 'package:medilink/features/main_pages/screens/reservation/widgets/nurse_reservation_page.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../controllers/nurse_announcement_controller.dart';


class NurseMainPage extends StatelessWidget {
  const NurseMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NurseAnnouncementController());
    final isDark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
          controller.selectedTabIndex.value == 0
              ? 'Available Announcements'
              : 'My Reservations',
          style: Theme.of(context).textTheme.headlineSmall,
        )),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Tab Bar
          Container(
            decoration: BoxDecoration(
              color: isDark ? TColors.dark : TColors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.all(16),
            child: Obx(() => Row(
              children: [
                _buildTab(context, 0, 'Announcements', controller.selectedTabIndex.value),
                _buildTab(context, 1, 'My Requests', controller.selectedTabIndex.value),
              ],
            )),
          ),
          // Tab Content
          Expanded(
            child: Obx(() => IndexedStack(
              index: controller.selectedTabIndex.value,
              children: const [
                NurseAnnouncementsListPage(),
                NurseReservationsPage(),
              ],
            )),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(BuildContext context, int index, String title, int selectedIndex) {
    final isSelected = index == selectedIndex;
    final isDark = THelperFunctions.isDarkMode(context);

    return Expanded(
      child: GestureDetector(
        onTap: () => NurseAnnouncementController.instance.selectedTabIndex.value = index,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? TColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: isSelected
                  ? TColors.white
                  : isDark ? TColors.white : TColors.dark,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}