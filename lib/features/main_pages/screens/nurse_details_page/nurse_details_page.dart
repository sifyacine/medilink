import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medilink/features/main_pages/models/nurse_model.dart';
import 'package:medilink/features/main_pages/screens/appointment_details/Appointment_page.dart';
import 'package:medilink/utils/constants/colors.dart';

import '../../../../utils/helpers/helper_functions.dart';

class NurseDetailsPage extends StatelessWidget {
  final Nurse nurse;

  const NurseDetailsPage({Key? key, required this.nurse}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                buildHeader(),
                const SizedBox(height: 16),
                // Nurse Information Section
                buildNurseInfo(context),
                const SizedBox(height: 24),
                // Statistics Section
                buildStatistics(),
                const SizedBox(height: 24),
                // About Section
                buildAbout(context),
                const SizedBox(height: 16),
                // Availability Section
                buildAvailability(context),
                const SizedBox(height: 16),
                // Consultation Fee Section
                buildConsultationFee(context),
                const SizedBox(height: 24),
                // Book Appointment Button
                buildBookAppointmentButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Header with Back Arrow and Heart Icon
  Widget buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back(); // Basic back navigation
          },
        ),
        IconButton(
          icon: const Icon(Icons.favorite_border, color: TColors.primary),
          onPressed: () {
            // Placeholder for favorite action (stateless for now)
          },
        ),
      ],
    );
  }

  // Nurse Information with Profile Picture, Name, Title, and Location
  Widget buildNurseInfo(context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Column(
      children: [
        Center(
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 80,
              backgroundImage: nurse.nursePic.isNotEmpty
                  ? AssetImage(nurse.nursePic)
                  : const AssetImage("assets/images/user.png"),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: Text(
            nurse.fullName,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isDark ? TColors.light : TColors.dark,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Center(
          child: Text(
            "Nurse",
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.location_on, color: Colors.grey, size: 16),
            const SizedBox(width: 4),
            Text(
              "${nurse.city}, ${nurse.state}",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Statistics Section with Patients, Experience, and Rating
  Widget buildStatistics() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        buildStatCard("Patients", "500", Iconsax.personalcard),
        // Placeholder value
        buildStatCard("Experience", "6 Years", Iconsax.clock),
        // Placeholder value
        buildStatCard("Rating", calculateAverageRating().toStringAsFixed(1),
            Iconsax.star),
      ],
    );
  }

  // Reusable Stat Card Widget
  Widget buildStatCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: TColors.primary,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Icon(icon, color: TColors.white,size: 18),
          const SizedBox(height: 4),

          Text(
            value,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // About Section with Description
  Widget buildAbout(context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "About",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: isDark ? TColors.light : TColors.dark,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "${nurse.fullName} is a nurse in ${nurse
              .city}. Her qualification is MBBS - JCS. She is a senior consultant in the department of medical university hospital.",
          // Placeholder text
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  // Availability Section
  Widget buildAvailability(context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Available",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: isDark ? TColors.light : TColors.dark,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "Tuesday/Thursday 10:00/20:00", // Placeholder text
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  // Consultation Fee Section
  Widget buildConsultationFee(context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Fee",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: isDark ? TColors.light : TColors.dark,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "1500.00 DA", // Placeholder value
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  // Book Appointment Button
  Widget buildBookAppointmentButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Get.to(() => AppointmentPage());
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: TColors.primary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          "Book an appointment",
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // Calculate Average Rating from Nurse Model
  double calculateAverageRating() {
    if (nurse.reviews.isEmpty) return 0.0;
    return nurse.reviews.map((r) => r.rating).reduce((a, b) => a + b) /
        nurse.reviews.length;
  }
}