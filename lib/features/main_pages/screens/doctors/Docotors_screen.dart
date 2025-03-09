import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:midilink/common/widgets/appbar/appbar.dart';
import 'package:midilink/common/widgets/custom_shapes/containers/search_bar_container.dart';
import 'package:midilink/common/widgets/doctors/Doctors_circular_card.dart';
import 'package:midilink/common/widgets/doctors/doctor_card_horizontal.dart';
import 'package:midilink/common/widgets/texts/section_heading.dart';
import 'package:midilink/features/main_pages/screens/doctors/widgets/doctors_specialties.dart';
import 'package:midilink/utils/constants/image_strings.dart';

import '../../controllers/doctors_specialties_controller.dart';
import '../doctor_details/doctor_details.dart';

class DoctorsScreen extends StatelessWidget {
  const DoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Instantiate the controller once using Get.put
    final controller = Get.put(DoctorsSpecialtiesController());

    // Mock data for recommended doctors (3 items)
    final List<Map<String, dynamic>> recommendedDoctors = [
      {
        'name': 'Dr. Smith',
        'specialty': 'Cardiologist',
        'rating': 4.5,
        'distance': 'at 500 m',
        'imageUrl': TImages.user1,
        'bio': 'Dr. Smith is a highly experienced cardiologist specializing in heart diseases and preventive care.',
      },
      {
        'name': 'Dr. Johnson',
        'specialty': 'Dermatologist',
        'rating': 4.2,
        'distance': 'at 700 m',
        'imageUrl': TImages.user2,
        'bio': 'Dr. Johnson is a board-certified dermatologist known for her expertise in skin conditions and cosmetic treatments.',
      },
      {
        'name': 'Dr. Williams',
        'specialty': 'Neurologist',
        'rating': 4.8,
        'distance': 'at 600 m',
        'imageUrl': TImages.user3,
        'bio': 'Dr. Williams is a leading neurologist with a focus on brain disorders, migraines, and neurodegenerative diseases.',
      },
    ];

    // Mock data for recent doctors (5 items)
    final List<Map<String, dynamic>> recentDoctors = [
      {
        'name': 'Dr. Brown',
        'imageUrl': TImages.user4,
        'bio': 'Dr. Brown specializes in internal medicine, offering comprehensive health care for adults.',
      },
      {
        'name': 'Dr. Davis',
        'imageUrl': TImages.user5,
        'bio': 'Dr. Davis is a well-respected pediatrician providing expert care for infants, children, and adolescents.',
      },
      {
        'name': 'Dr. Miller',
        'imageUrl': TImages.user6,
        'bio': 'Dr. Miller is an orthopedic surgeon specializing in bone and joint disorders, including sports injuries.',
      },
      {
        'name': 'Dr. Wilson',
        'imageUrl': TImages.user7,
        'bio': 'Dr. Wilson is a renowned ophthalmologist dedicated to treating eye diseases and improving vision.',
      },
      {
        'name': 'Dr. Moore',
        'imageUrl': TImages.user8,
        'bio': 'Dr. Moore is a psychiatrist with extensive experience in mental health care and therapy.',
      },
    ];

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
              // Displaying only one doctor by using the first element with onTap redirect
              TDoctorCardHorizontal(
                name: recommendedDoctors[0]['name']?.toString() ?? 'Unknown Doctor',
                specialty: recommendedDoctors[0]['specialty']?.toString() ?? 'Unknown Specialty',
                rating: (recommendedDoctors[0]['rating'] is num)
                    ? (recommendedDoctors[0]['rating'] as num).toDouble()
                    : 0.0,
                distance: recommendedDoctors[0]['distance']?.toString() ?? 'N/A',
                imageUrl: recommendedDoctors[0]['imageUrl']?.toString() ?? '',
                onTap: () {
                  // Redirect to the details page, passing the doctor's info.
                  Get.to(
                    DoctorDetailsScreen(doctor: recommendedDoctors[0]),
                  );
                },
              ),
              const SizedBox(height: 24),
              const TSectionHeading(title: "Recent doctors"),
              SizedBox(
                height: 120, // Adjust height as needed
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: recentDoctors.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    final doctor = recentDoctors[index];
                    return DoctorsCircularCard(
                      imagePath: doctor['imageUrl'] as String,
                      doctorName: doctor['name'] as String,
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
