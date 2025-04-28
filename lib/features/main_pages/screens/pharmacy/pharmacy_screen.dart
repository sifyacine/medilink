import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:midilink/common/widgets/appbar/appbar.dart';
import 'package:midilink/common/widgets/custom_shapes/containers/search_bar_container.dart';
import 'package:midilink/common/widgets/products/product_cards/product_cards_vertical.dart';
import 'package:midilink/common/widgets/texts/section_heading.dart';
import 'package:midilink/features/main_pages/controllers/pharmacy_controller.dart';
import 'package:midilink/features/main_pages/screens/cart/cart.dart';
import 'package:midilink/features/main_pages/screens/pharmacy/widgets/pharmacy_promo_slider.dart';
import 'package:midilink/utils/constants/colors.dart';
import 'package:midilink/utils/constants/image_strings.dart';
import 'package:midilink/utils/constants/sizes.dart';
import 'package:midilink/utils/helpers/helper_functions.dart';
import '../../../../common/widgets/products/cart/cart_menu_icon.dart';
import '../medicine_details/medicne_detailss_screen.dart';

class PharmacyScreen extends StatelessWidget {
  const PharmacyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(PharmacyController());
    final Future<List<dynamic>> medicinesFuture = controller.loadMedicines();

    // Compute card dimensions.
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.45;
    // Approximate card height: image height + extra space for text and button.
    final cardHeight = cardWidth + 100;

    return Scaffold(
      appBar: TAppBar(
        title: const Text("Pharmacy"),
        centerTitle: true,
        showBackArrow: true,
        actions: [
          TCartCounterIcon(
            iconColor: isDark ? TColors.white : TColors.black,
            onPressed: () {
              Get.to(const CartScreen());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const TSearchContainer(
                text: 'Search...',
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              ),
              const TPharmacyPromoSlider(
                banners: [
                  TImages.pharmacyBanner,
                  TImages.pharmacyBanner,
                  TImages.pharmacyBanner,
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              // Popular Products Section.
              TSectionHeading(
                title: 'Popular products',
                showActionButton: true,
                onPressed: () {},
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              FutureBuilder<List<dynamic>>(
                future: medicinesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error loading medicines: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No medicines found'));
                  }
                  final medicines = snapshot.data!;
                  final displayedMedicines = medicines.take(3).toList();
                  return SizedBox(
                    height: cardHeight,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: displayedMedicines.length,
                      itemBuilder: (context, index) {
                        final medicine = displayedMedicines[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: TSizes.spaceBtwItems),
                          child: TProductCardVertical(
                            imageUrl: medicine['medicine_pic'] ?? TImages.productImage19,
                            discount: (medicine['discount'] as num) > 0
                                ? "${medicine['discount']}%"
                                : null,
                            title: medicine['medicine_name'],
                            price: medicine['medicine_price'],
                            manufacturer: medicine['manufacturer'],
                            onTap: () {
                              Get.to(() => ProductDetailsScreen(product: medicine));
                            },
                            onAdd: () {
                              // Handle add-to-cart functionality.
                            },
                            onFavoriteTap: () {
                              // Handle favorite toggle.
                            },
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              // Promotions Section.
              TSectionHeading(
                title: 'Promotions',
                showActionButton: true,
                onPressed: () {},
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              FutureBuilder<List<dynamic>>(
                future: medicinesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error loading promotions: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No promotions found'));
                  }
                  final medicines = snapshot.data!;
                  final promotions = medicines.where((medicine) => (medicine['discount'] as num) > 0).toList();
                  final displayedPromotions = promotions.take(2).toList();
                  return SizedBox(
                    height: cardHeight,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: displayedPromotions.length,
                      itemBuilder: (context, index) {
                        final medicine = displayedPromotions[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: TSizes.spaceBtwItems),
                          child: TProductCardVertical(
                            imageUrl: medicine['medicine_pic'] ?? TImages.productImage19,
                            discount: "${medicine['discount']}%",
                            title: medicine['medicine_name'],
                            price: medicine['medicine_price'],
                            manufacturer: medicine['manufacturer'],
                            onTap: () {
                              // Navigate to product details screen, passing the current medicine map.
                              Get.to(() => ProductDetailsScreen(product: medicine));
                            },

                            onAdd: () {
                              // Handle add-to-cart functionality.
                            },
                            onFavoriteTap: () {
                              // Handle favorite toggle.
                            },
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              // Additional promotions or content.
            ],
          ),
        ),
      ),
    );
  }
}
