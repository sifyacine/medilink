import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink/common/widgets/appbar/appbar.dart';
import 'package:medilink/common/widgets/custom_shapes/containers/search_bar_container.dart';
import 'package:medilink/common/widgets/doctors/Doctors_circular_card.dart';
import 'package:medilink/common/widgets/doctors/doctor_card_horizontal.dart';
import 'package:medilink/common/widgets/texts/section_heading.dart';
import 'package:medilink/features/main_pages/screens/doctors/widgets/doctors_specialties.dart';
import 'package:medilink/utils/constants/image_strings.dart';
import 'package:medilink/features/main_pages/screens/doctor_details/doctor_details.dart';
import 'package:medilink/features/main_pages/screens/home/home.dart';
import '../../../../data/dummy_data.dart';
import '../../controllers/doctors_specialties_controller.dart';
import '../../models/doctor_model.dart';
import '../../models/reviews_model.dart';

class DoctorsScreen extends StatelessWidget {
  const DoctorsScreen({super.key});

  double _calculateAverageRating(List<Review> reviews) {
    if (reviews.isEmpty) return 4.5;
    final total = reviews.fold(0.0, (sum, review) => sum + review.rating);
    return total / reviews.length;
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DoctorsSpecialtiesController());

    // Using your existing dummy doctors data from HomeScreen
    final List<Doctor> recommendedDoctors = dummyDoctors.sublist(0, 3);
    final List<Doctor> recentDoctors = dummyDoctors.sublist(3, 8);

    return Scaffold(
      appBar: TAppBar(
        title: const Text("Find doctors"),
        centerTitle: true,
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
          child: Column(
            children: [
              const TSearchContainer(text: "search doctors..."),
              Obx(
                    () => TSectionHeading(
                  title: "Specialties",
                  buttonTitle: controller.isExpanded.value ? "View Less" : "View More",
                  onPressed: () => controller.toggleExpanded(),
                  showActionButton: true,
                ),
              ),
              TDoctorsSpecialties(),
              const SizedBox(height: 24),
              const TSectionHeading(title: "Recommended doctors"),
              TDoctorCardHorizontal(
                name: recommendedDoctors[0].fullName,
                specialty: recommendedDoctors[0].medicalSpecialty.join(', '),
                rating: _calculateAverageRating(recommendedDoctors[0].reviews),
                distance: '1 km',
                imageUrl: recommendedDoctors[0].doctorPic,
                onTap: () {
                  Get.to(
                        () => DoctorDetailsScreen(doctor: recommendedDoctors[0]),
                  );
                },
              ),
              const SizedBox(height: 24),
              const TSectionHeading(title: "Recent doctors"),
              SizedBox(
                height: 120,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: recentDoctors.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    final doctor = recentDoctors[index];
                    return DoctorsCircularCard(
                      imagePath: doctor.doctorPic,
                      doctorName: doctor.fullName,
                      onTap: () => Get.to(
                              () => DoctorDetailsScreen(doctor: doctor)),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}