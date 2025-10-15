import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink/utils/constants/colors.dart';

import '../../../personalization/controllers/user_controller.dart';

// ==================== CONTROLLERS ====================

class NurseHomeController extends GetxController {
  final nurseName = 'Noor'.obs;
  final patientCount = 8.obs;
  final notificationCount = 3.obs;
  final activeVisits = <VisitModel>[].obs;
  final recentActivities = <ActivityModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() {
    // Simulate loading data
    activeVisits.value = [
      VisitModel(
        patientName: 'Eleanor',
        address: '123 Maple Street, anyTown',
        imageUrl: null,
      ),
    ];

    recentActivities.value = [
      ActivityModel(
        message: 'The appointment for patient Ahmed Ali has been rescheduled to July 4 at 10:00 AM.',
        timestamp: DateTime.now().subtract(Duration(hours: 2)),
      ),
      ActivityModel(
        message: 'An emergency was reported for patient Youssef Hassan.',
        timestamp: DateTime.now().subtract(Duration(hours: 5)),
      ),
      ActivityModel(
        message: 'New request: Visit patient Laila Mahmoud on July 5',
        timestamp: DateTime.now().subtract(Duration(days: 1)),
      ),
    ];
  }

  void handleNotificationTap() {
    Get.snackbar('Notifications', 'Opening notifications');
  }

  void viewVisit(VisitModel visit) {
    Get.snackbar('Visit', 'Opening visit with ${visit.patientName}');
  }

  void handleQuickAction(String action) {
    Get.snackbar('Action', 'Tapped $action');
  }
}

// ==================== MODELS ====================

class VisitModel {
  final String patientName;
  final String address;
  final String? imageUrl;

  VisitModel({
    required this.patientName,
    required this.address,
    this.imageUrl,
  });
}

class ActivityModel {
  final String message;
  final DateTime timestamp;

  ActivityModel({
    required this.message,
    required this.timestamp,
  });
}

// ==================== MAIN SCREEN ====================

class NurseHomeScreen extends StatelessWidget {
  const NurseHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NurseHomeController());

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              NurseHeaderCard(controller: controller),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionHeading(title: 'Active Visits'),
                    const SizedBox(height: 12),
                    Obx(() => Column(
                      children: controller.activeVisits
                          .map((visit) => ActiveVisitCard(
                        visit: visit,
                        onViewTap: () => controller.viewVisit(visit),
                      ))
                          .toList(),
                    )),
                    const SizedBox(height: 24),
                    const SectionHeading(title: 'Quick Actions'),
                    const SizedBox(height: 12),
                    QuickActionsGrid(controller: controller),
                    const SizedBox(height: 24),
                    const SectionHeading(title: 'Recent Activity'),
                    const SizedBox(height: 12),
                    Obx(() => Column(
                      children: controller.recentActivities
                          .map((activity) => RecentActivityItem(activity: activity))
                          .toList(),
                    )),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================== WIDGETS ====================

class NurseHeaderCard extends StatelessWidget {
  final NurseHomeController controller;

  const NurseHeaderCard({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(UserController());
    final userController = UserController.instance;
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF199A8E), Color(0xFF196A66)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 35, color: TColors.primary),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => Text(
                      'Good Morning ,${userController.user.value.fullName}!',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )),
                    const SizedBox(height: 4),
                    const Text(
                      'Ready to make a different today ?',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: controller.handleNotificationTap,
                icon: Stack(
                  children: [
                    const Icon(Icons.notifications_outlined, color: Colors.white, size: 28),
                    Obx(() => controller.notificationCount.value > 0
                        ? Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 18,
                          minHeight: 18,
                        ),
                        child: Text(
                          '${controller.notificationCount.value}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                        : const SizedBox.shrink()),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Today's Schedule",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Obx(() => Text(
                        '${controller.patientCount.value} Patients',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: TColors.primary,
                        ),
                      )),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: TColors.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.calendar_today,
                    color: TColors.primary,
                    size: 28,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SectionHeading extends StatelessWidget {
  final String title;

  const SectionHeading({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }
}

class ActiveVisitCard extends StatelessWidget {
  final VisitModel visit;
  final VoidCallback onViewTap;

  const ActiveVisitCard({
    Key? key,
    required this.visit,
    required this.onViewTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.grey[200],
            child: Icon(Icons.person, size: 30, color: Colors.grey[600]),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Visit With ${visit.patientName}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  visit.address,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: onViewTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: TColors.primary.withOpacity(0.1),
              foregroundColor: TColors.primary,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              'View',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class QuickActionsGrid extends StatelessWidget {
  final NurseHomeController controller;

  const QuickActionsGrid({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final actions = [
      QuickActionData(
        icon: Icons.message_outlined,
        title: 'Messages',
        subtitle: 'Upload and review patient reports easily',
      ),
      QuickActionData(
        icon: Icons.description_outlined,
        title: 'Reports',
        subtitle: 'Quick communication with patient\'s family',
      ),
      QuickActionData(
        icon: Icons.warning_amber_outlined,
        title: 'Emergency',
        subtitle: 'Quickly report emergencies to get help',
      ),
      QuickActionData(
        icon: Icons.book_outlined,
        title: 'Guidelines',
        subtitle: 'Tips and guidelines for medical cases',
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.1,
      ),
      itemCount: actions.length,
      itemBuilder: (context, index) {
        return QuickActionCard(
          data: actions[index],
          onTap: () => controller.handleQuickAction(actions[index].title),
        );
      },
    );
  }
}

class QuickActionData {
  final IconData icon;
  final String title;
  final String subtitle;

  QuickActionData({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
}

class QuickActionCard extends StatelessWidget {
  final QuickActionData data;
  final VoidCallback onTap;

  const QuickActionCard({
    Key? key,
    required this.data,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: TColors.primary.withOpacity(0.08),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              data.icon,
              size: 40,
              color: TColors.primary,
            ),
            const SizedBox(height: 12),
            Text(
              data.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              data.subtitle,
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class RecentActivityItem extends StatelessWidget {
  final ActivityModel activity;

  const RecentActivityItem({
    Key? key,
    required this.activity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 4),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: TColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle_outline,
              color: TColors.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              activity.message,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

