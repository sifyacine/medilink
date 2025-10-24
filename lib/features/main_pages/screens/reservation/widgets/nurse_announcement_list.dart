import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/nurse_announcement_controller.dart';
import 'announcement_card.dart';
import 'announcement_details_page.dart';
import 'filter_widget.dart';


class NurseAnnouncementsListPage extends StatelessWidget {
  const NurseAnnouncementsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NurseAnnouncementController());
    final isDark = THelperFunctions.isDarkMode(context);

    return Column(
      children: [
        // Search and Filter Bar
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: (value) {
                    controller.searchQuery.value = value;
                    controller.searchAnnouncements();
                  },
                  decoration: InputDecoration(
                    hintText: 'Search announcements...',
                    prefixIcon: const Icon(Iconsax.search_normal),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: isDark ? TColors.darkerGrey : TColors.light,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Filter Button
              GestureDetector(
                onTap: () => _showFilterBottomSheet(context),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: TColors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Iconsax.filter, color: TColors.white),
                ),
              ),
            ],
          ),
        ),

        // Announcements List
        Obx(() {
          if (controller.isLoading.value) {
            return const Expanded(
              child: Center(child: CircularProgressIndicator()),
            );
          }

          if (controller.announcements.isEmpty) {
            return Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Iconsax.note_remove, size: 64, color: TColors.grey),
                    const SizedBox(height: 16),
                    Text(
                      'No announcements found',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Try adjusting your filters or check back later',
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
              onRefresh: () => controller.loadAnnouncements(),
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.announcements.length,
                itemBuilder: (context, index) {
                  final announcement = controller.announcements[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: AnnouncementCard(
                      announcement: announcement,
                      onTap: () {
                        controller.setSelectedAnnouncement(announcement);
                        Get.to(() => AnnouncementDetailsPage());
                      },
                    ),
                  );
                },
              ),
            ),
          );
        }),
      ],
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    final controller = Get.find<NurseAnnouncementController>();
    final isDark = THelperFunctions.isDarkMode(context);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? TColors.dark : TColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const FilterWidget(),
    );
  }
}