// controllers/nurse_details_controller.dart
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../authentication/models/nurse_model.dart';

class NurseDetailsController extends GetxController {
  static NurseDetailsController get instance => Get.find();

  final Rx<NurseModel> nurse = NurseModel.empty().obs;
  final RxBool isLoading = true.obs;
  final RxString error = ''.obs;

  // Fetch nurse details
  Future<void> fetchNurseDetails(String nurseId) async {
    try {
      isLoading.value = true;
      error.value = '';

      final doc = await FirebaseFirestore.instance
          .collection('nurses')
          .doc(nurseId)
          .get();

      if (doc.exists) {
        nurse.value = NurseModel.fromSnapshot(doc);
      } else {
        throw 'Nurse not found';
      }
    } catch (e) {
      error.value = 'Failed to load nurse details: $e';
    } finally {
      isLoading.value = false;
    }
  }

  // Get availability status
  String get availabilityStatus {
    final availability = nurse.value.availability;
    if (availability == null || availability.isEmpty) {
      return 'Not specified';
    }

    // You can customize this based on your availability structure
    final now = DateTime.now();
    final today = now.weekday.toString();

    if (availability.containsKey(today)) {
      final todaySchedule = availability[today];
      if (todaySchedule is Map && todaySchedule['available'] == true) {
        return 'Available Today';
      }
    }

    return 'Check Availability';
  }

  // Calculate years of experience (you might want to add this field to your model)
  String get experience {
    // This is a placeholder - you might want to add an experience field to your model
    final joinedYear = nurse.value.createdAt.year;
    final currentYear = DateTime.now().year;
    final years = currentYear - joinedYear;
    return years <= 0 ? 'Recent' : '$years+ years';
  }
}