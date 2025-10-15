import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants/colors.dart';

// ==================== CONTROLLERS ====================

class BrowseRequestController extends GetxController {
  final searchQuery = ''.obs;
  final selectedCareType = 'All'.obs;
  final selectedDistance = 'All'.obs;
  final selectedDateTime = 'All'.obs;
  final requests = <RequestModel>[].obs;
  final filteredRequests = <RequestModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadRequests();
  }

  void loadRequests() {
    requests.value = [
      RequestModel(
        patientName: 'Ahlam Ahmed',
        careType: 'Sitter',
        dateTime: 'June 26, 2025 - 4:00 PM',
        location: 'Algiers',
        imageUrl: null,
      ),
      RequestModel(
        patientName: 'Maha Mohammed',
        careType: 'Health Care',
        dateTime: 'June 28, 2025 - 5:00 PM',
        location: 'Algiers',
        imageUrl: null,
      ),
    ];
    filteredRequests.value = requests;
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    filterRequests();
  }

  void filterRequests() {
    filteredRequests.value = requests.where((request) {
      final matchesSearch = searchQuery.value.isEmpty ||
          request.patientName.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
          request.careType.toLowerCase().contains(searchQuery.value.toLowerCase());
      return matchesSearch;
    }).toList();
  }

  void showCareTypeFilter() {
    Get.snackbar('Filter', 'Care Type filter clicked');
  }

  void showDistanceFilter() {
    Get.snackbar('Filter', 'Distance filter clicked');
  }

  void showDateTimeFilter() {
    Get.snackbar('Filter', 'Date/Time filter clicked');
  }

  void viewRequestDetails(RequestModel request) {
    Get.snackbar('Request', 'Viewing details for ${request.patientName}');
  }

  void handleNotificationTap() {
    Get.snackbar('Notifications', 'Opening notifications');
  }
}

// ==================== MODELS ====================

class RequestModel {
  final String patientName;
  final String careType;
  final String dateTime;
  final String location;
  final String? imageUrl;

  RequestModel({
    required this.patientName,
    required this.careType,
    required this.dateTime,
    required this.location,
    this.imageUrl,
  });
}

// ==================== MAIN SCREEN ====================

class BrowseRequestScreen extends StatelessWidget {
  const BrowseRequestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BrowseRequestController());

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: BrowseRequestAppBar(
        onNotificationTap: controller.handleNotificationTap,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SearchTextField(
                  onChanged: controller.updateSearchQuery,
                ),
                const SizedBox(height: 16),
                FilterChipsRow(controller: controller),
              ],
            ),
          ),
          Expanded(
            child: Obx(() => ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: controller.filteredRequests.length,
              itemBuilder: (context, index) {
                final request = controller.filteredRequests[index];
                return RequestCard(
                  request: request,
                  onViewDetails: () => controller.viewRequestDetails(request),
                );
              },
            )),
          ),
        ],
      ),
    );
  }
}

// ==================== WIDGETS ====================

class BrowseRequestAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onNotificationTap;

  const BrowseRequestAppBar({
    Key? key,
    required this.onNotificationTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(Icons.arrow_back, color: Colors.black87),
      ),
      title: const Text(
        'Browse Request',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: onNotificationTap,
          icon: const Icon(
            Icons.notifications_outlined,
            color: TColors.primary,
            size: 28,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class SearchTextField extends StatelessWidget {
  final Function(String) onChanged;

  const SearchTextField({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Search for care type',
          hintStyle: TextStyle(
            color: Colors.grey[500],
            fontSize: 16,
          ),
          border: InputBorder.none,
          icon: Icon(Icons.search, color: Colors.grey[600]),
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
}

class FilterChipsRow extends StatelessWidget {
  final BrowseRequestController controller;

  const FilterChipsRow({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: FilterChip(
            label: 'Care type',
            isSelected: true,
            onTap: controller.showCareTypeFilter,
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          flex: 1,
          child: FilterChip(
            label: 'Distance',
            isSelected: false,
            onTap: controller.showDistanceFilter,
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          flex: 1,
          child: FilterChip(
            label: 'Date/Time',
            isSelected: false,
            onTap: controller.showDateTimeFilter,
          ),
        ),
      ],
    );
  }
}

class FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const FilterChip({
    Key? key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(25),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.white,
          border: Border.all(
            color: isSelected ? TColors.primary : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: isSelected ? TColors.primary : Colors.grey[600],
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            const SizedBox(width: 2),
            Icon(
              Icons.keyboard_arrow_down,
              size: 16,
              color: isSelected ? TColors.primary : Colors.grey[600],
            ),
          ],
        ),
      ),
    );
  }
}

class RequestCard extends StatelessWidget {
  final RequestModel request;
  final VoidCallback onViewDetails;

  const RequestCard({
    Key? key,
    required this.request,
    required this.onViewDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey[200],
                child: Icon(Icons.person, size: 35, color: Colors.grey[600]),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request.patientName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: TColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        request.careType,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: TColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 18, color: Colors.grey[600]),
              const SizedBox(width: 8),
              Text(
                request.dateTime,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.location_on, size: 18, color: Colors.grey[600]),
              const SizedBox(width: 8),
              Text(
                request.location,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onViewDetails,
              style: ElevatedButton.styleFrom(
                backgroundColor: TColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'view Details',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
