import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../styles/shadows.dart';
import '../../custom_shapes/containers/rounded_container.dart';
import '../../icon/circular_icon.dart';
import '../../images/rounded_images.dart';

class TProductCardsHorizontal extends StatelessWidget {
  const TProductCardsHorizontal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final screenWidth = MediaQuery.of(context).size.width;
    // Card occupies 80% of the screen width.
    final cardWidth = screenWidth * 0.8;
    // Thumbnail takes about 35% of the card width.
    final thumbnailSize = cardWidth * 0.35;
    // The remaining width is for the details.
    final detailsWidth = cardWidth - thumbnailSize;

    return Container(
      width: cardWidth,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        boxShadow: [TShadowStyle.verticalProductShadow],
        borderRadius: BorderRadius.circular(TSizes.productImageRadius),
        color: isDark ? TColors.darkGrey : TColors.white,
      ),
      child: Row(
        children: [
          // Thumbnail section.
          TRoundedContainer(
            height: thumbnailSize,
            width: thumbnailSize,
            padding: const EdgeInsets.all(TSizes.sm),
            backgroundColor: isDark ? TColors.dark : TColors.light,
            child: Stack(
              children: [
                // Thumbnail image.
                SizedBox(
                  width: thumbnailSize,
                  height: thumbnailSize,
                  child: TRoundedImage(
                    imageUrl: "assets/images/medicines/Adjustable Back Support Belt.jpg",
                    fit: BoxFit.cover, // Ensures the image covers the container.
                    applyImageRadius: true,
                  ),
                ),
                // Sale tag.
                Positioned(
                  top: 12,
                  left: 12,
                  child: TRoundedContainer(
                    radius: TSizes.sm,
                    backgroundColor: TColors.secondary.withOpacity(0.8),
                    padding: const EdgeInsets.symmetric(
                        vertical: TSizes.xs, horizontal: TSizes.sm),
                    child: Text(
                      '25%',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .apply(color: TColors.black),
                    ),
                  ),
                ),
                // Favorite icon.
                const Positioned(
                  top: 0,
                  right: 0,
                  child: TCircularIcon(
                    icon: Iconsax.heart5,
                    color: Colors.redAccent,
                  ),
                ),
              ],
            ),
          ),
          // Details section.
          SizedBox(
            width: detailsWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Optional details can be added here.
                const SizedBox(height: TSizes.sm),
                // Spacer pushes the add-to-cart button to the bottom.
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // You can add pricing or other details here.
                      // Add-to-cart button.
                      Container(
                        decoration: const BoxDecoration(
                          color: TColors.dark,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(TSizes.cardRadiusMd),
                            bottomRight: Radius.circular(TSizes.productImageRadius),
                          ),
                        ),
                        child: SizedBox(
                          width: TSizes.iconLg * 1.2,
                          height: TSizes.iconLg * 1.2,
                          child: const Center(
                            child: Icon(Iconsax.add, color: TColors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: TSizes.sm),
              ],
            ),
          )
        ],
      ),
    );
  }
}
