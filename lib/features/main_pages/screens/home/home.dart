import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medilink/common/widgets/doctors/doctor_card_vertical.dart';
import 'package:medilink/common/widgets/products/product_cards/product_cards_vertical.dart';
import 'package:medilink/data/dummy_data.dart';
import 'package:medilink/features/main_pages/models/doctor_model.dart';
import 'package:medilink/features/main_pages/screens/home/widgets/home_appbar.dart';
import 'package:medilink/features/main_pages/screens/home/widgets/home_categories.dart';
import 'package:medilink/features/main_pages/screens/home/widgets/home_search_bar.dart';
import 'package:medilink/features/main_pages/screens/home/widgets/promo_slider.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../models/medicine_model.dart';
import '../all_doctors/all-doctors.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final List<Product> products = [
    product1,
    product2,
    product3,
    product4,
    product5,
    product6,
  ];
  // List of doctors with bios
  final List<Doctor> doctors = [
    doctor1,
    doctor2,
    doctor3,
    doctor4,
    doctor5,
    doctor6,
    doctor7,
    doctor8,
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
                Row(
                  children: [
                    Expanded(child: TSearchContainer(hintText: 'Search...')),
                    IconButton(
                      icon: const Icon(Iconsax.filter, size: 28),
                      color: TColors.primary,
                      splashRadius: TSizes.md,
                      tooltip: 'Filter',
                      onPressed: () {
                        // TODO: open filter panel
                      },
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwSections),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: const TPromoSlider(
                    banners: [
                      TImages.promoBanner1,
                      TImages.promoBanner2,
                      TImages.promoBanner3,
                    ],
                  ),
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

            /// popular nurses
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TSectionHeading(
                    title: 'Popular nurses',
                    showActionButton: true,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => AllDoctorsScreen(doctors: doctors),
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
                            name: doctor.fullName,
                            specialty: doctor.medicalSpecialty.toString(),
                            rating: 4.3,
                            distance: "1 KM",
                            imageUrl: doctor.doctorPic,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            /// recent orders

            /// popular products
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TSectionHeading(
                    title: 'Popular doctors',
                    showActionButton: true,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => AllDoctorsScreen(doctors: doctors),
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
                        final product = products[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: TProductCardVertical(
                            title: product.name,
                            discount: product.reductionPercentage.toString(),
                            onFavoriteTap: (){},
                            onTap: (){},
                            onAdd: (){},
                            price: product.price,
                            imageUrl: product.imageUrl,
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