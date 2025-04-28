import 'package:flutter/material.dart';
import 'package:midilink/common/widgets/appbar/appbar.dart';
import 'package:midilink/utils/constants/colors.dart';
import 'package:midilink/utils/constants/image_strings.dart';
import 'package:midilink/utils/constants/sizes.dart';
import 'package:midilink/utils/helpers/helper_functions.dart';
import '../../../../common/widgets/products/rating/rating_indicator.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailsScreen({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int quantity = 1;
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final product = widget.product;

    // Extract product data
    final String title = product['medicine_name'] ?? 'No name';
    final String dosage = product['dosage'] ?? 'No dosage';
    final String manufacturer = product['manufacturer'] ?? 'No manufacturer';
    final String imageUrl = product['medicine_pic'] ?? '';
    final double price = (product['medicine_price'] as num?)?.toDouble() ?? 0.0;
    final int discount = (product['discount'] as num?)?.toInt() ?? 0;
    final String description = product['description'] ?? 'No description';
    final double rating = 4.0;

    return Scaffold(
      appBar: TAppBar(
        title: Text(title),
        centerTitle: true,
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: TSizes.defaultSpace),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: isDark ? Colors.grey[800] : Colors.grey[200],
                ),
                child: imageUrl.isNotEmpty
                    ? Image.asset(imageUrl, fit: BoxFit.contain)
                    : const Icon(Icons.image_not_supported),
              ),
            ),

            // Manufacturer
            Row(
              children: [
                CircleAvatar(backgroundImage: AssetImage(TImages.pharmacy)),
                const SizedBox(width: TSizes.defaultSpace),
                Text(manufacturer),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            // Title
            Text(title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: TSizes.sm),

            // Dosage, Rating, and Favorite
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(dosage, style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: TSizes.md),
                    Row(
                      children: [
                        TRatingBarIndicator(rating: rating),
                        const SizedBox(width: TSizes.sm),
                        Text(rating.toStringAsFixed(1), style: Theme.of(context).textTheme.bodyMedium),

                      ],
                    ),
                    ],
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : null),
                  onPressed: () => setState(() => isFavorite = !isFavorite),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            // Price, Quantity, and Buy Button Row
            Row(
              children: [
                // Price and Discount
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$price DA',
                        style: Theme.of(context).textTheme.headlineMedium!
                            .copyWith(color: TColors.primary)),
                    if (discount > 0)
                      Container(
                        margin: const EdgeInsets.only(top: TSizes.xs),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text('-$discount%', style: const TextStyle(color: Colors.red)),
                      ),
                  ],
                ),
                const Spacer(),

                // Quantity Controls
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove, size: 20),
                        onPressed: () => setState(() => quantity = quantity > 1 ? quantity - 1 : 1),
                      ),
                      Text('$quantity', style: Theme.of(context).textTheme.titleSmall),
                      IconButton(
                        icon: const Icon(Icons.add, size: 20),
                        onPressed: () => setState(() => quantity++),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: TSizes.spaceBtwItems),


              ],
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            // Description
            Text('Description', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(description, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: TSizes.spaceBtwItems),
            // Buy Button
            Row(
              children: [
                Text(
                  '$price DA',
                  style: Theme.of(context).textTheme.headlineSmall!
                      .copyWith(color: TColors.primary),
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: TColors.primary,
                      foregroundColor: TColors.white,
                    ),
                    onPressed: () {/* Add to cart logic */},
                    child: const Text('Acheter'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}