import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medilink/common/styles/shadows.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../custom_shapes/containers/rounded_container.dart';
import '../images/rounded_images.dart';

class TDoctorCardsVertical extends StatelessWidget {
  const TDoctorCardsVertical({
    Key? key,
    required this.name,
    required this.specialty,
    required this.rating,
    required this.distance,
    required this.imageUrl,
    this.onTap,
  }) : super(key: key);

  final String name;
  final String specialty;
  final double rating;
  final String distance;
  final String imageUrl;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(TSizes.sm),
        decoration: BoxDecoration(
          boxShadow: [TShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: isDark ? TColors.darkGrey : TColors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Doctor Photo
            TRoundedContainer(
              width: double.infinity,
              height: 120,
              backgroundColor: isDark ? TColors.dark : TColors.light,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(TSizes.productImageRadius),
                child: TRoundedImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            // Doctor Name
            Text(
              name,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: TSizes.xs),

            // Specialty
            Text(
              specialty,
              style: Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.grey),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            // Rating & Distance Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Rating
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.orange, size: 16),
                      const SizedBox(width: TSizes.xs),
                      Text(
                        rating.toStringAsFixed(1),
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  // Distance
                  Row(
                    children: [
                      const Icon(Iconsax.location, size: 14),
                      const SizedBox(width: TSizes.xs),
                      Text(
                        distance,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
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