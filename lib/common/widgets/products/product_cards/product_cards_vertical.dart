import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../styles/shadows.dart';
import '../../custom_shapes/containers/rounded_container.dart';
import '../../images/rounded_images.dart';

class TProductCardVertical extends StatelessWidget {
  final String imageUrl;
  final String? discount;
  final String? title;
  final String? manufacturer;
  final double? price;
  final bool isFavorite;
  final VoidCallback? onTap;
  final VoidCallback? onAdd;
  final VoidCallback? onFavoriteTap;

  const TProductCardVertical({
    super.key,
    required this.imageUrl,
    this.discount,
    this.title,
    this.manufacturer,
    this.price,
    this.isFavorite = false,
    this.onTap,
    this.onAdd,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.45;
    final imageHeight = cardWidth;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cardWidth,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [TShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: isDark ? TColors.darkGrey : TColors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            TRoundedContainer(
              height: imageHeight,
              width: cardWidth,
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: isDark ? TColors.dark : TColors.light,
              child: Stack(
                children: [
                  TRoundedImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    applyImageRadius: true,
                  ),
                  if (discount != null)
                    Positioned(
                      top: 0,
                      left: 0,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: cardWidth * 0.5),
                        child: TRoundedContainer(
                          radius: TSizes.sm,
                          backgroundColor: Colors.red.withOpacity(0.8),
                          padding: const EdgeInsets.symmetric(
                            vertical: TSizes.xs,
                            horizontal: TSizes.sm,
                          ),
                          child: Text(
                            discount!,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .apply(color: TColors.white),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // Text Content Section
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (title != null)
                      SizedBox(
                        width: cardWidth - 2 * TSizes.sm,
                        child: Text(
                          title!,
                          style: Theme.of(context).textTheme.titleSmall,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    if (manufacturer != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Flexible(
                          child: Text(
                            manufacturer!,
                            style: Theme.of(context).textTheme.bodySmall!.apply(
                              color: isDark ? TColors.dark : TColors.grey,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // Price & Add to Cart
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: TSizes.sm, vertical: 8),
              child: Row(
                children: [
                  if (price != null)
                    Expanded(
                      child: SizedBox(
                        child: Text(
                          "DZD${price!.toStringAsFixed(2)}",
                          style: Theme.of(context).textTheme.titleSmall,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ),
                  Container(
                    height: TSizes.iconLg,
                    width: TSizes.iconLg,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(TSizes.cardRadiusMd),
                        bottomRight: Radius.circular(TSizes.productImageRadius),
                      ),
                      color: TColors.primary,
                    ),
                    child: IconButton(
                      onPressed: onAdd,
                      icon: Icon(Iconsax.add, size: TSizes.iconSm, color: TColors.light),
                      padding: EdgeInsets.zero,
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