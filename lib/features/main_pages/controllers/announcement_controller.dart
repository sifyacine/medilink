import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink/features/main_pages/models/announcment_model.dart';
import 'package:medilink/features/personalization/controllers/user_controller.dart';
import 'package:medilink/data/services/announcement_services.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class AnnouncementController extends GetxController {
  static AnnouncementController get instance => Get.find();

  // Dependencies
  final AnnouncementService _announcementService = AnnouncementService();

  // Location data observables
  final RxList<String> states = <String>[].obs;
  final RxList<String> cities = <String>[].obs;
  final RxList<dynamic> allLocationData = <dynamic>[].obs;
  final RxString selectedState = ''.obs;
  final RxString selectedCity = ''.obs;

  // Observable lists with pagination support
  final RxList<Announcement> allAnnouncements = <Announcement>[].obs;
  final RxList<Announcement> activeAnnouncements = <Announcement>[].obs;
  final RxList<Announcement> userAnnouncements = <Announcement>[].obs;
  final RxList<Announcement> filteredAnnouncements = <Announcement>[].obs;

  // Pagination variables
  final RxBool hasMoreActiveAnnouncements = true.obs;
  final RxBool hasMoreUserAnnouncements = true.obs;
  DocumentSnapshot? _lastActiveDoc;
  DocumentSnapshot? _lastUserDoc;

  // Loading states
  final RxBool isLoading = false.obs;
  final RxBool isSubmitting = false.obs;
  final RxBool isRefreshing = false.obs;
  final RxBool isLocationDataLoading = false.obs;
  final RxBool isLoadingMore = false.obs;

  // Form controllers
  final descriptionController = TextEditingController();
  final startingPointController = TextEditingController();
  final endingPointController = TextEditingController();

  // Form observables
  final RxString selectedTargetAudience = ''.obs;
  final Rx<DateTime?> selectedStartDate = Rx<DateTime?>(null);
  final Rx<TimeOfDay?> selectedStartTime = Rx<TimeOfDay?>(null);
  final Rx<TimeOfDay?> selectedEndTime = Rx<TimeOfDay?>(null);
  final RxInt minAge = 0.obs;
  final RxInt maxAge = 100.obs;
  final RxBool isActive = true.obs;

  // Search and filter observables
  final RxString searchKeyword = ''.obs;
  final RxString filterState = ''.obs;
  final RxString filterCity = ''.obs;
  final RxString filterTargetAudience = ''.obs;
  final RxInt filterMinAge = 0.obs;
  final RxInt filterMaxAge = 100.obs;
  final Rx<DateTime?> filterStartDate = Rx<DateTime?>(null);

  // Sort options
  final RxString sortBy = 'createdAt'.obs;
  final RxBool sortDescending = true.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeData();
  }

  @override
  void onClose() {
    descriptionController.dispose();
    startingPointController.dispose();
    endingPointController.dispose();
    super.onClose();
  }

  /// Initialize all required data
  void _initializeData() {
    loadStatesAndCities();
    fetchActiveAnnouncements();
    fetchUserAnnouncements();
  }

  /// Loads states and cities data from local JSON asset
  Future<void> loadStatesAndCities() async {
    try {
      isLocationDataLoading.value = true;
      final data = await rootBundle.loadString('assets/data/states_cities.json');
      final List<dynamic> jsonData = json.decode(data);
      allLocationData.assignAll(jsonData);

      final stateList = jsonData
          .map((item) => item['wilaya_name'] as String)
          .toSet()
          .toList()
        ..sort();
      states.assignAll(stateList);
    } catch (e) {
      _showErrorSnackbar("Failed to load states and cities", e.toString());
    } finally {
      isLocationDataLoading.value = false;
    }
  }

  /// Load cities for a given state
  void loadCitiesForState(String stateName) {
    try {
      final cityList = allLocationData
          .where((item) => item['wilaya_name'] == stateName)
          .map((item) => item['commune_name'] as String)
          .toList()
        ..sort();
      cities.assignAll(cityList);
    } catch (e) {
      _showErrorSnackbar("Failed to load cities for $stateName", e.toString());
    }
  }

  /// Select a state and load corresponding cities
  void selectState(String stateName) {
    selectedState.value = stateName;
    selectedCity.value = '';
    loadCitiesForState(stateName);
  }

  /// Select a city
  void selectCity(String cityName) {
    selectedCity.value = cityName;
  }

  /// Fetch active announcements with pagination
  Future<void> fetchActiveAnnouncements({bool loadMore = false}) async {
    if ((!loadMore && isLoading.value) || (loadMore && isLoadingMore.value)) return;

    try {
      if (loadMore) {
        isLoadingMore.value = true;
      } else {
        isLoading.value = true;
        _lastActiveDoc = null;
        hasMoreActiveAnnouncements.value = true;
      }

      if (!hasMoreActiveAnnouncements.value && loadMore) return;

      final announcements = await _announcementService.getActiveAnnouncements(
        orderBy: sortBy.value,
        descending: sortDescending.value,
        limit: 20,
        lastDoc: loadMore ? _lastActiveDoc : null,
      );

      if (announcements.isNotEmpty) {
        _lastActiveDoc = await _getLastDocumentSnapshot(announcements);

        if (loadMore) {
          activeAnnouncements.addAll(announcements);
        } else {
          activeAnnouncements.assignAll(announcements);
        }

        // Check if we have more data to load
        hasMoreActiveAnnouncements.value = announcements.length == 20;
      } else {
        if (!loadMore) activeAnnouncements.clear();
        hasMoreActiveAnnouncements.value = false;
      }
    } catch (e) {
      _showErrorSnackbar('Failed to fetch active announcements', e.toString());
      if (!loadMore) activeAnnouncements.clear();
    } finally {
      if (loadMore) {
        isLoadingMore.value = false;
      } else {
        isLoading.value = false;
      }
    }
  }

  /// Fetch user announcements with pagination
  Future<void> fetchUserAnnouncements({bool loadMore = false}) async {
    if ((!loadMore && isLoading.value) || (loadMore && isLoadingMore.value)) return;

    try {
      if (loadMore) {
        isLoadingMore.value = true;
      } else {
        isLoading.value = true;
        _lastUserDoc = null;
        hasMoreUserAnnouncements.value = true;
      }

      if (!hasMoreUserAnnouncements.value && loadMore) return;

      final userController = Get.put(UserController());
      final userId = userController.user.value.id;

      if (userId.isEmpty) {
        userAnnouncements.clear();
        return;
      }

      final announcements = await _announcementService.getAnnouncementsByPublisher(
        userId,
        limit: 20,
        lastDoc: loadMore ? _lastUserDoc : null,
      );

      if (announcements.isNotEmpty) {
        _lastUserDoc = await _getLastDocumentSnapshot(announcements);

        if (loadMore) {
          userAnnouncements.addAll(announcements);
        } else {
          userAnnouncements.assignAll(announcements);
        }

        hasMoreUserAnnouncements.value = announcements.length == 20;
      } else {
        if (!loadMore) userAnnouncements.clear();
        hasMoreUserAnnouncements.value = false;
      }
    } catch (e) {
      _showErrorSnackbar('Failed to fetch your announcements', e.toString());
      if (!loadMore) userAnnouncements.clear();
    } finally {
      if (loadMore) {
        isLoadingMore.value = false;
      } else {
        isLoading.value = false;
      }
    }
  }

  /// Helper method to get last document snapshot for pagination
  Future<DocumentSnapshot?> _getLastDocumentSnapshot(List<Announcement> announcements) async {
    if (announcements.isEmpty) return null;

    try {
      final lastAnnouncement = announcements.last;
      return await _announcementService.getDocumentSnapshot(lastAnnouncement.uid);
    } catch (e) {
      print('Error getting last document snapshot: $e');
      return null;
    }
  }

  /// Get a single announcement by ID with caching
  Future<Announcement?> getAnnouncementById(String uid, {bool incrementViews = true}) async {
    try {
      // Check if announcement is already in any of our lists
      Announcement? cachedAnnouncement = _findCachedAnnouncement(uid);
      if (cachedAnnouncement != null) {
        if (incrementViews) {
          await _announcementService.incrementViews(uid);
        }
        return cachedAnnouncement;
      }

      // Fetch from service if not cached
      final announcement = await _announcementService.getAnnouncementById(uid);
      if (announcement != null && incrementViews) {
        await _announcementService.incrementViews(uid);
      }
      return announcement;
    } catch (e) {
      _showErrorSnackbar('Failed to fetch announcement', e.toString());
      return null;
    }
  }

  /// Find announcement in cached lists
  Announcement? _findCachedAnnouncement(String uid) {
    final allLists = [activeAnnouncements, userAnnouncements, allAnnouncements, filteredAnnouncements];

    for (final list in allLists) {
      final announcement = list.firstWhereOrNull((a) => a.uid == uid);
      if (announcement != null) return announcement;
    }
    return null;
  }

  /// Create a new announcement
  Future<bool> createAnnouncement(Announcement announcement) async {
    if (isSubmitting.value) return false;

    try {
      isSubmitting.value = true;

      final userController = Get.put(UserController());
      announcement.publisherId = userController.user.value.id;

      await _announcementService.createAnnouncement(announcement);

      _showSuccessSnackbar('Announcement created successfully');

      // Refresh lists
      await Future.wait([
        fetchActiveAnnouncements(),
        fetchUserAnnouncements(),
      ]);

      return true;
    } catch (e) {
      _showErrorSnackbar('Failed to create announcement', e.toString());
      return false;
    } finally {
      isSubmitting.value = false;
    }
  }

  /// Update an existing announcement
  Future<bool> updateAnnouncement(Announcement announcement) async {
    if (isSubmitting.value) return false;

    try {
      isSubmitting.value = true;
      await _announcementService.updateAnnouncement(announcement);

      _showSuccessSnackbar('Announcement updated successfully');

      // Update local lists
      _updateAnnouncementInLists(announcement);

      return true;
    } catch (e) {
      _showErrorSnackbar('Failed to update announcement', e.toString());
      return false;
    } finally {
      isSubmitting.value = false;
    }
  }

  /// Delete an announcement
  Future<bool> deleteAnnouncement(String uid) async {
    if (isSubmitting.value) return false;

    try {
      isSubmitting.value = true;
      await _announcementService.deleteAnnouncement(uid);

      _showSuccessSnackbar('Announcement deleted successfully');

      // Remove from local lists
      _removeAnnouncementFromLists(uid);

      return true;
    } catch (e) {
      _showErrorSnackbar('Failed to delete announcement', e.toString());
      return false;
    } finally {
      isSubmitting.value = false;
    }
  }

  /// Update announcement status
  Future<bool> updateAnnouncementStatus(String uid, String newStatus) async {
    try {
      await _announcementService.updateAnnouncementStatus(uid, newStatus);
      _updateLocalAnnouncementStatus(uid, newStatus);

      _showSuccessSnackbar('Status updated to $newStatus');
      return true;
    } catch (e) {
      _showErrorSnackbar('Failed to update status', e.toString());
      return false;
    }
  }

  /// Search announcements with filters
  Future<void> searchAnnouncements() async {
    if (isLoading.value) return;

    try {
      isLoading.value = true;

      final results = await _announcementService.searchAnnouncements(
        keyword: searchKeyword.value.isEmpty ? null : searchKeyword.value,
        city: filterCity.value.isEmpty ? null : filterCity.value,
        state: filterState.value.isEmpty ? null : filterState.value,
        targetAudience: filterTargetAudience.value.isEmpty ? null : filterTargetAudience.value,
        minAge: filterMinAge.value > 0 ? filterMinAge.value : null,
        maxAge: filterMaxAge.value < 100 ? filterMaxAge.value : null,
        startDate: filterStartDate.value,
      );

      filteredAnnouncements.assignAll(results);
    } catch (e) {
      _showErrorSnackbar('Search failed', e.toString());
      filteredAnnouncements.clear();
    } finally {
      isLoading.value = false;
    }
  }

  /// Clear all filters and search results
  void clearFilters() {
    searchKeyword.value = '';
    filterCity.value = '';
    filterState.value = '';
    filterTargetAudience.value = '';
    filterMinAge.value = 0;
    filterMaxAge.value = 100;
    filterStartDate.value = null;
    filteredAnnouncements.clear();
  }

  /// Reset form to initial state
  void resetForm() {
    descriptionController.clear();
    startingPointController.clear();
    endingPointController.clear();
    selectedState.value = '';
    selectedCity.value = '';
    selectedTargetAudience.value = '';
    selectedStartDate.value = null;
    selectedStartTime.value = null;
    selectedEndTime.value = null;
    minAge.value = 0;
    maxAge.value = 100;
    isActive.value = true;
  }

  /// Validate form data
  bool validateForm() {
    if (selectedState.value.isEmpty) {
      _showValidationError('Please select a state');
      return false;
    }
    if (selectedCity.value.isEmpty) {
      _showValidationError('Please select a city');
      return false;
    }
    if (selectedTargetAudience.value.isEmpty) {
      _showValidationError('Please select target audience');
      return false;
    }
    if (selectedStartDate.value == null) {
      _showValidationError('Please select a start date');
      return false;
    }
    if (selectedStartTime.value == null) {
      _showValidationError('Please select a start time');
      return false;
    }
    if (selectedEndTime.value == null) {
      _showValidationError('Please select an end time');
      return false;
    }
    if (startingPointController.text.trim().isEmpty) {
      _showValidationError('Please enter a starting point');
      return false;
    }
    if (endingPointController.text.trim().isEmpty) {
      _showValidationError('Please enter an ending point');
      return false;
    }
    return true;
  }

  /// Submit a new announcement
  Future<bool> submitGuardingService() async {
    if (!validateForm()) return false;

    final announcement = Announcement(
      uid: '',
      publisherId: '',
      state: selectedState.value,
      city: selectedCity.value,
      targetAudience: selectedTargetAudience.value,
      startDate: selectedStartDate.value!,
      startTime: selectedStartTime.value!,
      endTime: selectedEndTime.value!,
      startingPoint: startingPointController.text.trim(),
      endingPoint: endingPointController.text.trim(),
      additionalNotes: descriptionController.text.trim(),
      minAge: minAge.value > 0 ? minAge.value : null,
      maxAge: maxAge.value < 100 ? maxAge.value : null,
      isActive: isActive.value,
      status: 'Pending',
      views: 0,
      createdAt: DateTime.now().toUtc(),
      updatedAt: DateTime.now().toUtc(),
    );

    final success = await createAnnouncement(announcement);
    if (success) resetForm();
    return success;
  }

  /// Refresh all data (pull-to-refresh)
  Future<void> refreshAnnouncements() async {
    if (isRefreshing.value) return;

    try {
      isRefreshing.value = true;
      await Future.wait([
        fetchActiveAnnouncements(),
        fetchUserAnnouncements(),
      ]);
    } catch (e) {
      _showErrorSnackbar('Failed to refresh announcements', e.toString());
    } finally {
      isRefreshing.value = false;
    }
  }

  // Private helper methods
  void _showErrorSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  void _showSuccessSnackbar(String message) {
    Get.snackbar(
      'Success',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void _showValidationError(String message) {
    Get.snackbar(
      'Validation Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.orange,
      colorText: Colors.white,
    );
  }

  void _updateAnnouncementInLists(Announcement updatedAnnouncement) {
    final lists = [userAnnouncements, activeAnnouncements, allAnnouncements, filteredAnnouncements];

    for (final list in lists) {
      final index = list.indexWhere((a) => a.uid == updatedAnnouncement.uid);
      if (index != -1) {
        list[index] = updatedAnnouncement;
        list.refresh();
      }
    }
  }

  void _removeAnnouncementFromLists(String uid) {
    final lists = [userAnnouncements, activeAnnouncements, allAnnouncements, filteredAnnouncements];

    for (final list in lists) {
      list.removeWhere((a) => a.uid == uid);
    }
  }

  void _updateLocalAnnouncementStatus(String uid, String newStatus) {
    final lists = [userAnnouncements, activeAnnouncements, allAnnouncements, filteredAnnouncements];

    for (final list in lists) {
      final index = list.indexWhere((a) => a.uid == uid);
      if (index != -1) {
        list[index].status = newStatus;
        list.refresh();
      }
    }
  }
}