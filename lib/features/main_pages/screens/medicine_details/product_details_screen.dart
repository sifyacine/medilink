import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:medilink/common/widgets/appbar/appbar.dart';
import 'package:medilink/utils/constants/colors.dart';
import 'package:medilink/utils/constants/sizes.dart';
import 'package:medilink/common/widgets/products/rating/rating_indicator.dart';
import 'package:medilink/features/main_pages/controllers/product_details_controller.dart';
import 'package:medilink/features/main_pages/controllers/wishlist_controller.dart';

import '../../models/medicine_model.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  ProductDetailsScreen({Key? key, required this.product}) : super(key: key) {
    Get.put(ProductDetailsController(product));
    Get.put(WishlistController(), permanent: true);
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<ProductDetailsController>();
    final wish = Get.find<WishlistController>();

    return Scaffold(
      appBar: TAppBar(
        title: Text(product.name),
        centerTitle: true,
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // PRODUCT IMAGE
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[200],
                ),
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  product.imageUrl,
                  height: 200,
                  fit: BoxFit.contain,
                  errorBuilder:
                      (_, __, ___) => const Icon(Icons.image_not_supported),
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            // NAME & WISHLIST BUTTON
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Add this
              children: [
                Text(
                  product.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Obx(
                  () => IconButton(
                    icon: Icon(
                      wish.isInWishlist(product)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: wish.isInWishlist(product) ? Colors.red : null,
                    ),
                    onPressed: () {
                      if (wish.isInWishlist(product)) {
                        wish.removeFromWishlist(product);
                      } else {
                        wish.addToWishlist(product);
                      }
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: TSizes.sm),
            Text(
              'Category: ${product.category}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'Size: ${product.size}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              'Material: ${product.material}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: TSizes.md),

            Text(
              'Stock: ${product.stock}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'Status: ${product.isAvailable ? 'Available' : 'Unavailable'}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            Text(
              'Added: ${product.addedDate.toLocal().toString().split(' ')[0]}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            // RATING
            Obx(() {
              final avg =
                  product.ratings.isNotEmpty
                      ? product.ratings
                              .map((r) => r.rating)
                              .reduce((a, b) => a + b) /
                          product.ratings.length
                      : 0.0;
              return Row(
                children: [
                  TRatingBarIndicator(rating: ctrl.averageRating.value),
                  const SizedBox(width: TSizes.sm),
                  Text(
                    avg.toStringAsFixed(1),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  if (product.ratings.isNotEmpty)
                    Text(
                      ' (${product.ratings.length} reviews)',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                ],
              );
            }),
            const SizedBox(height: TSizes.spaceBtwSections),

            // PRICE & DISCOUNT
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${ctrl.discountedPrice.toStringAsFixed(2)} DA',
                  style: Theme.of(
                    context,
                  ).textTheme.headlineMedium!.copyWith(color: TColors.primary),
                ),
                if (ctrl.discount > 0) ...[
                  Text(
                    '${ctrl.originalPrice.toStringAsFixed(2)} DA',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: TSizes.xs),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '-${ctrl.discount}%',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            // QUANTITY CONTROLS
            Obx(() {
              return Row(
                children: [
                  Obx(
                    () => Text(
                      'Quantity: ${ctrl.quantity.value}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  const SizedBox(width: TSizes.spaceBtwItems),
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed:
                        ctrl.quantity.value > 1 ? ctrl.decrementQuantity : null,
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed:
                        ctrl.quantity.value < product.stock
                            ? ctrl.incrementQuantity
                            : null,
                  ),
                ],
              );
            }),
            const SizedBox(height: TSizes.spaceBtwSections),

            // STOCK WARNINGS
            if (product.stock <= 0)
              const Text('Out of stock', style: TextStyle(color: Colors.red))
            else if (product.stock <= 5)
              Text(
                'Only ${product.stock} left',
                style: const TextStyle(color: Colors.orange),
              ),
            const SizedBox(height: TSizes.spaceBtwSections),

            // DESCRIPTION
            Text(
              'Description',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: TSizes.sm),
            Text(
              product.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            // BUY BUTTON
            Obx(() {
              final total = (ctrl.discountedPrice * ctrl.quantity.value)
                  .toStringAsFixed(2);
              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: ctrl.quantity.value > 0 ? () {} : null,
                  child: Text('Acheter $total DA'),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
