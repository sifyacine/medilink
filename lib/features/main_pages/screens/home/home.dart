import 'package:flutter/material.dart';
import 'package:midilink/common/widgets/doctors/doctor_card_vertical.dart';
import 'package:midilink/features/main_pages/screens/home/widgets/home_appbar.dart';
import 'package:midilink/features/main_pages/screens/home/widgets/home_categories.dart';
import 'package:midilink/features/main_pages/screens/home/widgets/promo_slider.dart';
import '../../../../common/widgets/custom_shapes/containers/search_bar_container.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../all_doctors/all-doctors.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  // List of doctors with bios
  final List<Map<String, dynamic>> doctors = [
    {
      'name': 'Dr. Sarah Smith',
      'specialty': 'Cardiologist',
      'rating': 4.9,
      'distance': '1.2 km',
      'image': TImages.user1,
      'bio': 'Dr. Sarah Smith is a highly experienced cardiologist specializing in heart health and cardiovascular diseases. She has over 15 years of experience helping patients manage heart conditions effectively.'
    },
    {
      'name': 'Dr. Michael Johnson',
      'specialty': 'Dermatologist',
      'rating': 4.7,
      'distance': '0.8 km',
      'image': TImages.user2,
      'bio': 'Dr. Michael Johnson is a board-certified dermatologist with expertise in treating various skin conditions, including acne, eczema, and skin cancer prevention.'
    },
    {
      'name': 'Dr. Emily Wilson',
      'specialty': 'Pediatrician',
      'rating': 4.8,
      'distance': '2.1 km',
      'image': TImages.user3,
      'bio': 'Dr. Emily Wilson is a compassionate pediatrician dedicated to the health and well-being of children. She has extensive experience in child development and preventive care.'
    },
    {
      'name': 'Dr. James Brown',
      'specialty': 'Neurologist',
      'rating': 4.6,
      'distance': '1.5 km',
      'image': TImages.user4,
      'bio': 'Dr. James Brown is a neurologist specializing in treating neurological disorders such as migraines, epilepsy, and Parkinson’s disease. He is known for his patient-centered approach to treatment.'
    },
    {
      'name': 'Dr. Olivia Davis',
      'specialty': 'Ophthalmologist',
      'rating': 4.9,
      'distance': '3.0 km',
      'image': TImages.user5,
      'bio': 'Dr. Olivia Davis is an ophthalmologist with a passion for eye care and vision correction. She specializes in cataract surgery and laser eye treatments.'
    },
    {
      'name': 'Dr. William Miller',
      'specialty': 'Orthopedic Surgeon',
      'rating': 4.5,
      'distance': '2.4 km',
      'image': TImages.user6,
      'bio': 'Dr. William Miller is an orthopedic surgeon focusing on bone and joint health. He has performed numerous successful knee and hip replacement surgeries.'
    },
    {
      'name': 'Dr. Sophia Wilson',
      'specialty': 'Dentist',
      'rating': 4.8,
      'distance': '1.8 km',
      'image': TImages.user7,
      'bio': 'Dr. Sophia Wilson is a skilled dentist providing exceptional dental care, including cosmetic and restorative treatments to enhance smiles and oral health.'
    },
    {
      'name': 'Dr. Benjamin Taylor',
      'specialty': 'Psychiatrist',
      'rating': 4.7,
      'distance': '2.7 km',
      'image': TImages.user8,
      'bio': 'Dr. Benjamin Taylor is a compassionate psychiatrist helping patients manage mental health conditions such as anxiety, depression, and stress-related disorders.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                const THomeAppBar(),
                const SizedBox(height: 12),
                const TSearchContainer(
                  text: 'Search...',
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                Padding(
                  padding: const EdgeInsets.only(left: TSizes.defaultSpace),
                  child: Column(
                    children: [
                      TSectionHeading(
                        title: 'Services',
                        textColor: isDark ? TColors.white : TColors.black,
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems),
                      THomeCategories(
                        textColor: isDark ? TColors.white : TColors.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TPromoSlider(
                    banners: [
                      TImages.promoBanner1,
                      TImages.promoBanner2,
                      TImages.promoBanner3,
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  TSectionHeading(
                    title: 'Popular doctors',
                    showActionButton: true,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AllDoctorsScreen(doctors: doctors),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  SizedBox(
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        final doctor = doctors[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: TDoctorCardsVertical(
                            name: doctor['name'],
                            specialty: doctor['specialty'],
                            rating: doctor['rating'],
                            distance: doctor['distance'],
                            imageUrl: doctor['image'],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
