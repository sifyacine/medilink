import 'package:flutter/material.dart';
import 'package:midilink/common/widgets/doctors/doctor_card_vertical.dart';
import 'package:midilink/features/main_pages/screens/home/widgets/home_appbar.dart';
import 'package:midilink/features/main_pages/screens/home/widgets/home_categories.dart';
import 'package:midilink/features/main_pages/screens/home/widgets/promo_slider.dart';
import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/custom_shapes/containers/search_bar_container.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../all_doctors/all-doctors.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  // List of doctors (could be fetched from an API or a provider)
  final List<Map<String, dynamic>> doctors = [
    {
      'name': 'Dr. Sarah Smith',
      'specialty': 'Cardiologist',
      'rating': 4.9,
      'distance': '1.2 km',
      'image': TImages.user1,
    },
    {
      'name': 'Dr. Michael Johnson',
      'specialty': 'Dermatologist',
      'rating': 4.7,
      'distance': '0.8 km',
      'image': TImages.user2,
    },
    {
      'name': 'Dr. Emily Wilson',
      'specialty': 'Pediatrician',
      'rating': 4.8,
      'distance': '2.1 km',
      'image': TImages.user3,
    },
    {
      'name': 'Dr. James Brown',
      'specialty': 'Neurologist',
      'rating': 4.6,
      'distance': '1.5 km',
      'image': TImages.user4,
    },
    {
      'name': 'Dr. Olivia Davis',
      'specialty': 'Ophthalmologist',
      'rating': 4.9,
      'distance': '3.0 km',
      'image': TImages.user5,
    },
    {
      'name': 'Dr. William Miller',
      'specialty': 'Orthopedic Surgeon',
      'rating': 4.5,
      'distance': '2.4 km',
      'image': TImages.user6,
    },
    {
      'name': 'Dr. Sophia Wilson',
      'specialty': 'Dentist',
      'rating': 4.8,
      'distance': '1.8 km',
      'image': TImages.user7,
    },
    {
      'name': 'Dr. Benjamin Taylor',
      'specialty': 'Psychiatrist',
      'rating': 4.7,
      'distance': '2.7 km',
      'image': TImages.user8,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// header part
            const TPrimaryHeaderContainer(
              child: Column(
                children: [
                  /// appBar
                  THomeAppBar(),

                  /// searchbar
                  TSearchContainer(
                    text: 'Search...',
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                  /// categories
                  Padding(
                    padding: EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      children: [
                        /// heading
                        TSectionHeading(
                          title: 'Services',
                          textColor: TColors.white,
                        ),
                        SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),

                        /// categories
                        THomeCategories()
                      ],
                    ),
                  ),
                  SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),

            /// body part
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// promo slider
                  const TPromoSlider(
                    banners: [
                      TImages.promoBanner1,
                      TImages.promoBanner2,
                      TImages.promoBanner3,
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  /// section heading with "view more" action
                  TSectionHeading(
                    title: 'Popular doctors',
                    showActionButton: true,
                    onPressed: () {
                      // Navigate to a new page that displays all doctors.
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AllDoctorsScreen(doctors: doctors),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  /// Horizontal list of 3 doctors
                  SizedBox(
                    height: 250, // Adjust according to the card height
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3, // Show only the first three
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
