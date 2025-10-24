import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medilink/features/main_pages/controllers/nurse_controller.dart';
import 'package:medilink/features/main_pages/screens/home/widgets/nurse_card.dart';
import 'package:medilink/features/main_pages/screens/nurse_page/nurse_page.dart';
import 'package:medilink/features/main_pages/screens/home/widgets/home_appbar.dart';
import 'package:medilink/features/main_pages/screens/home/widgets/home_categories.dart';
import 'package:medilink/features/main_pages/screens/home/widgets/home_search_bar.dart';
import 'package:medilink/features/main_pages/screens/home/widgets/promo_slider.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../nurse_details_page/nurse_details_page.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final NurseController nurseController = Get.put(NurseController());

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

            /// Popular Nurses Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TSectionHeading(
                    title: 'Popular Nurses',
                    showActionButton: true,
                    onPressed: () {
                      // Navigate to NursePage
                      Get.to(() => const NursePage());
                    },
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  // Nurses List with GetX Observer
                  Obx(() {
                    if (nurseController.isLoading.value) {
                      return _buildLoadingShimmer();
                    }

                    if (nurseController.errorMessage.isNotEmpty) {
                      return _buildErrorWidget();
                    }

                    final nurses = nurseController.filteredNurses.take(3).toList();

                    if (nurses.isEmpty) {
                      return _buildEmptyWidget();
                    }

                    return SizedBox(
                      height: 250,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: nurses.length,
                        itemBuilder: (context, index) {
                          final nurse = nurses[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: NurseCardVertical(
                              nurse: nurse,
                              onTap: () {
                                // Navigate to nurse details
                                Get.to(() => NurseDetailsPage(nurse: nurse));
                              },
                            ),
                          );
                        },
                      ),
                    );
                  }),
                ],
              ),
            ),

            const SizedBox(height: TSizes.spaceBtwSections),
          ],
        ),
      ),
    );
  }

  // Loading Shimmer Widget
  Widget _buildLoadingShimmer() {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
              width: 180,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image placeholder
                  Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Text placeholders
                  Container(
                    height: 16,
                    width: 100,
                    color: Colors.grey[300],
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    height: 14,
                    width: 80,
                    color: Colors.grey[300],
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    height: 14,
                    width: 60,
                    color: Colors.grey[300],
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Error Widget
  Widget _buildErrorWidget() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.grey),
            const SizedBox(height: 8),
            Text(
              nurseController.errorMessage.value,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => nurseController.loadAllNurses(),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  // Empty Widget
  Widget _buildEmptyWidget() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people_outline, size: 48, color: Colors.grey),
            SizedBox(height: 8),
            Text(
              'No nurses available',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}