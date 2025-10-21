import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medilink/common/widgets/appbar/appbar.dart';
import 'package:medilink/common/widgets/texts/section_heading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:medilink/features/main_pages/controllers/announcement_controller.dart';
import 'package:medilink/features/main_pages/screens/announcment/widgets/announcement_card.dart';
import 'package:medilink/features/main_pages/models/announcment_model.dart';
import 'package:medilink/features/personalization/controllers/user_controller.dart';
import 'package:medilink/utils/helpers/helper_functions.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../utils/constants/colors.dart';
import 'add_announcement.dart';

class AnnouncementPage extends StatelessWidget {
  const AnnouncementPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure controllers are available
    final userController = Get.put(UserController());
    final controller = Get.put(AnnouncementController());
    final isDarkMode = THelperFunctions.isDarkMode(context);

    return Scaffold(
      floatingActionButton: Obx(() {
        // Only show FAB if user is logged in
        if (userController.user.value.id.isEmpty) {
          return const SizedBox.shrink();
        }
        return FloatingActionButton(
          onPressed: () => Get.to(() => AnnouncementFormScreen()),
          backgroundColor: TColors.primary,
          child: const Icon(Iconsax.add, color: Colors.white),
          tooltip: "Create New Announcement",
        );
      }),
      appBar: TAppBar(
        title: const Text("My Announcements"),
        showBackArrow: false,
        actions: [
          // Debug button - remove this in production
          IconButton(
            icon: const Icon(Iconsax.refresh),
            onPressed: () {
              print('🔄 Manual refresh triggered');
              controller.fetchUserAnnouncements();
            },
          ),
        ],
      ),
      body: Obx(() {
        print('🎯 Page rebuild - User ID: ${userController.user.value.id}');
        print('📊 Announcements count: ${controller.userAnnouncements.length}');
        print('⏳ Loading: ${controller.isLoading.value}');

        // Check if user is logged in
        if (userController.user.value.id.isEmpty) {
          return _buildLoginPrompt(context);
        }

        // Trigger fetch if list is empty and not loading
        if (controller.userAnnouncements.isEmpty &&
            !controller.isLoading.value &&
            !controller.isRefreshing.value) {
          print('🚀 Triggering fetch because list is empty');
          // Use Future.microtask to avoid calling during build
          Future.microtask(() => controller.fetchUserAnnouncements());
        }

        return RefreshIndicator(
          onRefresh: () => controller.fetchUserAnnouncements(),
          child: _buildAnnouncementsList(controller, context),
        );
      }),
    );
  }

  Widget _buildLoginPrompt(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Iconsax.user, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 24),
            Text(
              "Please log in to view",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "your announcements",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => Get.offAllNamed('/login'),
              icon: const Icon(Iconsax.login),
              label: const Text("Sign In"),
              style: ElevatedButton.styleFrom(
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnnouncementsList(
      AnnouncementController controller, BuildContext context) {
    return Obx(() {
      // Show shimmer loading on initial load
      if (controller.isLoading.value &&
          controller.userAnnouncements.isEmpty) {
        print('🔄 Showing shimmer loading');
        return _buildShimmerLoading(context);
      }

      // Show empty state
      if (controller.userAnnouncements.isEmpty && !controller.isLoading.value) {
        print('📭 Showing empty state');
        return _buildEmptyState(context);
      }

      // Show announcements list
      print('📋 Showing ${controller.userAnnouncements.length} announcements');
      return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          // Load more when reaching the bottom
          if (!controller.isLoadingMore.value &&
              controller.hasMoreUserAnnouncements.value &&
              scrollInfo.metrics.pixels >=
                  scrollInfo.metrics.maxScrollExtent - 200) {
            controller.fetchUserAnnouncements(loadMore: true);
          }
          return false;
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TSectionHeading(
                  title:
                  "Your Announcements (${controller.userAnnouncements.length})",
                  showActionButton: false,
                ),
                const SizedBox(height: 16),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.userAnnouncements.length,
                  separatorBuilder: (context, index) =>
                  const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final announcement = controller.userAnnouncements[index];
                    return AnnouncementCard(
                      announcement: announcement,
                      onTap: () => _showAnnouncementDetails(
                          context, announcement, controller),
                      onDelete: () =>
                          _confirmDelete(context, announcement, controller),
                      onEdit: () => _editAnnouncement(announcement),
                    );
                  },
                ),
                // Loading more indicator
                if (controller.isLoadingMore.value)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                // No more data indicator
                if (!controller.hasMoreUserAnnouncements.value &&
                    controller.userAnnouncements.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Center(
                      child: Text(
                        "No more announcements",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[500],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildShimmerLoading(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header shimmer
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: 200,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Card shimmers
            ...List.generate(
              3,
                  (index) => Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: _buildShimmerCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerCard() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title shimmer
            Container(
              width: double.infinity,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 12),
            // Subtitle shimmer
            Container(
              width: 150,
              height: 16,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 8),
            // Another line
            Container(
              width: 200,
              height: 16,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 12),
            // Status badge shimmer
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 80,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                Container(
                  width: 60,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Iconsax.clipboard_text, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 24),
            Text(
              "No announcements yet",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Create your first guarding service",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => Get.to(() => AnnouncementFormScreen()),
              icon: const Icon(Iconsax.add),
              label: const Text("Create Announcement"),
              style: ElevatedButton.styleFrom(
                backgroundColor: TColors.primary,
                foregroundColor: Colors.white,
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
            // Temporary debug button
            ElevatedButton(
              onPressed: () async {
                final userController = Get.put(UserController());
                final userId = userController.user.value.id;
                print('🔍 Testing query for userId: $userId');

                // Direct Firestore query
                final snapshot = await FirebaseFirestore.instance
                    .collection('announcements')
                    .where('publisherId', isEqualTo: userId)
                    .get();

                print('📊 Found ${snapshot.docs.length} documents');
                for (var doc in snapshot.docs) {
                  print('📄 Doc ID: ${doc.id}');
                  print('   Data: ${doc.data()}');
                }
              },
              child: const Text('Test Firestore Query'),
            ),
          ],
        ),
      ),
    );
  }

  void _showAnnouncementDetails(
      BuildContext context,
      Announcement announcement,
      AnnouncementController controller,
      ) {
    final dateFormat = DateFormat('MMM d, yyyy');
    final timeFormat = DateFormat('hh:mm a');

    final startDate = dateFormat.format(announcement.startDate);
    final endDate = announcement.endDate != null
        ? dateFormat.format(announcement.endDate!)
        : null;

    final startTime = timeFormat.format(
      DateTime(
          2023, 1, 1, announcement.startTime.hour, announcement.startTime.minute),
    );
    final endTime = timeFormat.format(
      DateTime(2023, 1, 1, announcement.endTime.hour, announcement.endTime.minute),
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(
              _getStatusIcon(announcement.status),
              color: _getStatusColor(announcement.status),
            ),
            const SizedBox(width: 8),
            const Expanded(child: Text("Announcement Details")),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow(context, "Service",
                  "Guarding ${announcement.targetAudience}"),
              _buildDetailRow(context, "Date", startDate),
              if (endDate != null && announcement.deplacementType != null)
                _buildDetailRow(context, "End Date", endDate),
              _buildDetailRow(context, "Time", "$startTime - $endTime"),
              if (announcement.deplacementType != null)
                _buildDetailRow(
                  context,
                  "Type",
                  _getDeplacementTypeText(announcement.deplacementType!),
                ),
              if (announcement.deplacementFrequency != null)
                _buildDetailRow(
                  context,
                  "Frequency",
                  "${announcement.deplacementFrequency}x per ${_getFrequencyPeriod(announcement.deplacementType)}",
                ),
              if (announcement.state.isNotEmpty ||
                  announcement.city.isNotEmpty)
                _buildDetailRow(context, "Location",
                    "${announcement.city}, ${announcement.state}"),
              if (announcement.startingPoint != null &&
                  announcement.startingPoint!.isNotEmpty)
                _buildDetailRow(
                    context, "Starting Point", announcement.startingPoint!),
              if (announcement.endingPoint != null &&
                  announcement.endingPoint!.isNotEmpty)
                _buildDetailRow(
                    context, "Ending Point", announcement.endingPoint!),
              if (announcement.minAge != null || announcement.maxAge != null)
                _buildDetailRow(
                  context,
                  "Age Range",
                  "${announcement.minAge ?? 0} - ${announcement.maxAge ?? 100} years",
                ),
              _buildDetailRow(
                context,
                "Status",
                announcement.status,
                color: _getStatusColor(announcement.status),
              ),
              if (announcement.additionalNotes.isNotEmpty) ...[
                const Divider(height: 24),
                Text(
                  "Additional Notes:",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  announcement.additionalNotes,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Iconsax.eye, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        "${announcement.views} views",
                        style:
                        Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: announcement.isActive
                          ? TColors.primary.withOpacity(0.1)
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      announcement.isActive ? "Active" : "Inactive",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: announcement.isActive
                            ? TColors.primary
                            : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
          if (announcement.status == 'Pending' ||
              announcement.status == 'Active')
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _editAnnouncement(announcement);
              },
              child: const Text("Edit"),
            ),
        ],
      ),
    );
  }

  void _confirmDelete(
      BuildContext context,
      Announcement announcement,
      AnnouncementController controller,
      ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Iconsax.trash, color: Colors.red),
            SizedBox(width: 8),
            Text("Delete Announcement"),
          ],
        ),
        content: Text(
          "Are you sure you want to delete this ${announcement.targetAudience} guarding service? This action cannot be undone.",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              Navigator.pop(context);
              await controller.deleteAnnouncement(announcement.uid);
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  void _editAnnouncement(Announcement announcement) {
    Get.to(() => AnnouncementFormScreen(announcement: announcement));
  }

  Widget _buildDetailRow(BuildContext context, String label, String value,
      {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              "$label:",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: color ?? Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
      case 'approved':
        return TColors.primary;
      case 'pending':
        return Colors.orange;
      case 'completed':
        return Colors.blue;
      case 'cancelled':
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'active':
      case 'approved':
        return Iconsax.tick_circle;
      case 'pending':
        return Iconsax.clock;
      case 'completed':
        return Iconsax.tick_square;
      case 'cancelled':
      case 'rejected':
        return Iconsax.close_circle;
      default:
        return Iconsax.info_circle;
    }
  }

  String _getDeplacementTypeText(DeplacementType type) {
    switch (type) {
      case DeplacementType.oneTime:
        return "One-Time Service";
      case DeplacementType.daily:
        return "Daily Service";
      case DeplacementType.weekly:
        return "Weekly Service";
      case DeplacementType.monthly:
        return "Monthly Service";
    }
  }

  String _getFrequencyPeriod(DeplacementType? type) {
    if (type == null) return "";
    switch (type) {
      case DeplacementType.daily:
        return "day";
      case DeplacementType.weekly:
        return "week";
      case DeplacementType.monthly:
        return "month";
      default:
        return "";
    }
  }
}