import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medilink/common/widgets/appbar/appbar.dart';
import 'package:medilink/common/widgets/custom_shapes/containers/search_bar_container.dart';
import 'package:medilink/common/widgets/products/product_cards/product_cards_vertical.dart';
import 'package:medilink/common/widgets/texts/section_heading.dart';
import 'package:medilink/features/main_pages/controllers/pharmacy_controller.dart';
import 'package:medilink/features/main_pages/screens/cart/cart.dart';
import 'package:medilink/features/main_pages/screens/pharmacy/widgets/pharmacy_promo_slider.dart';
import 'package:medilink/features/main_pages/screens/wishlist_page/wishlist_page.dart';
import 'package:medilink/utils/constants/colors.dart';
import 'package:medilink/utils/constants/sizes.dart';
import 'package:medilink/utils/helpers/helper_functions.dart';

import '../../../../common/widgets/products/cart/cart_menu_icon.dart';
import '../../../../utils/constants/image_strings.dart';
import '../medicine_details/product_details_screen.dart';

class PharmacyScreen extends StatelessWidget {
  const PharmacyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(PharmacyController());

    // Card sizing based on screen width
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.45;
    final cardHeight = cardWidth + 100;

    return Scaffold(
      appBar: TAppBar(
        title: const Text('Pharmacy'),
        centerTitle: true,
        showBackArrow: true,
        actions: [
          TCartCounterIcon(
            iconColor: isDark ? TColors.white : TColors.black,
            onPressed: () => Get.to(() => const CartScreen()),
          ),
          IconButton(
            onPressed: () => Get.to(() => WishlistScreen()),
            icon: Icon(Iconsax.heart),
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
              const SizedBox(height: TSizes.spaceBtwSections),
              const TPharmacyPromoSlider(
                banners: [
                  TImages.pharmacyBanner,
                  TImages.pharmacyBanner,
                  TImages.pharmacyBanner,
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Popular Products
              TSectionHeading(
                title: 'Popular Products',
                showActionButton: true,
                onPressed: () {},
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              Obx(() {
                final products = controller.products;
                if (products.isEmpty) {
                  return const Center(child: Text('No products available'));
                }
                final popular = products.take(3).toList();
                return SizedBox(
                  height: cardHeight,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: popular.length,
                    itemBuilder: (context, index) {
                      final product = popular[index];
                      return Padding(
                        padding: const EdgeInsets.only(
                          right: TSizes.spaceBtwItems,
                        ),
                        child: TProductCardVertical(
                          imageUrl: product.imageUrl,
                          discount:
                              product.reductionPercentage > 0
                                  ? '${product.reductionPercentage}%'
                                  : null,
                          title: product.name,
                          price: product.price,
                          manufacturer: product.manufacturer.name,
                          onTap:
                              () => Get.to(
                                () => ProductDetailsScreen(product: product),
                              ),
                          onAdd: () {
                            // TODO: Add to cart logic
                          },
                          onFavoriteTap: () {
                            // TODO: Favorite toggle logic
                          },
                        ),
                      );
                    },
                  ),
                );
              }),

              const SizedBox(height: TSizes.spaceBtwSections),

              // Promotions
              TSectionHeading(
                title: 'Promotions',
                showActionButton: true,
                onPressed: () {},
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              Obx(() {
                final products = controller.products;
                final promos =
                    products
                        .where((p) => p.reductionPercentage > 0)
                        .take(2)
                        .toList();
                if (promos.isEmpty) {
                  return const Center(child: Text('No promotions found'));
                }
                return SizedBox(
                  height: cardHeight,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: promos.length,
                    itemBuilder: (context, index) {
                      final product = promos[index];
                      return Padding(
                        padding: const EdgeInsets.only(
                          right: TSizes.spaceBtwItems,
                        ),
                        child: TProductCardVertical(
                          imageUrl: product.imageUrl,
                          discount: '${product.reductionPercentage}%',
                          title: product.name,
                          price: product.price,
                          manufacturer: product.manufacturer.name,
                          onTap:
                              () => Get.to(
                                () => ProductDetailsScreen(product: product),
                              ),
                          onAdd: () {
                            // TODO: Add to cart logic
                          },
                          onFavoriteTap: () {
                            // TODO: Favorite toggle logic
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
      ),
    );
  }
}
