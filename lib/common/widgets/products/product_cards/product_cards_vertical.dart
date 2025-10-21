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

    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate card width as 45% of parent width or screen width, whichever is smaller
        final cardWidth = constraints.maxWidth < MediaQuery.of(context).size.width * 0.45
            ? constraints.maxWidth
            : MediaQuery.of(context).size.width * 0.45;

        return GestureDetector(
          onTap: onTap,
          child: Container(
            width: cardWidth,
            decoration: BoxDecoration(
              boxShadow: [TShadowStyle.verticalProductShadow],
              borderRadius: BorderRadius.circular(TSizes.productImageRadius),
              color: isDark ? TColors.darkGrey : TColors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Section with Aspect Ratio
                TRoundedContainer(
                  padding: const EdgeInsets.all(TSizes.sm),
                  backgroundColor: isDark ? TColors.dark : TColors.light,
                  child: AspectRatio(
                    aspectRatio: 1.0, // Ensure square image area
                    child: Stack(
                      children: [
                        TRoundedImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                          applyImageRadius: true,
                          width: double.infinity,
                          height: double.infinity,
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
                ),
                // Text Content Section
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: TSizes.sm, vertical: TSizes.xs),
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
                              maxLines: 2, // Allow two lines for title
                            ),
                          ),
                        if (manufacturer != null)
                          Padding(
                            padding: const EdgeInsets.only(top: TSizes.xs),
                            child: Text(
                              manufacturer!,
                              style: Theme.of(context).textTheme.bodySmall!.apply(
                                color: isDark ? TColors.dark : TColors.grey,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                // Price & Add to Cart
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: TSizes.sm, vertical: TSizes.sm),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (price != null)
                        Expanded(
                          child: Text(
                            "DZD${price!.toStringAsFixed(2)}",
                            style: Theme.of(context).textTheme.titleSmall,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      Container(
                        height: TSizes.iconLg,
                        width: TSizes.iconLg,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(TSizes.cardRadiusMd),
                            bottomRight: Radius.circular(TSizes.productImageRadius),
                          ),
                          color: TColors.primary,
                        ),
                        child: IconButton(
                          onPressed: onAdd,
                          icon: const Icon(Iconsax.add, size: TSizes.iconSm, color: TColors.light),
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
      },
    );
  }
}