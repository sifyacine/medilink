// common/widgets/nurse/nurse_card_vertical.dart
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medilink/features/main_pages/models/nurse_model.dart';
import 'package:medilink/utils/constants/colors.dart';
import 'package:medilink/utils/constants/image_strings.dart';
import 'package:medilink/utils/constants/sizes.dart';
import 'package:medilink/utils/helpers/helper_functions.dart';

import '../../../../authentication/models/nurse_model.dart';

class NurseCardVertical extends StatelessWidget {
  final NurseModel nurse;
  final VoidCallback? onTap;
  final double width;

  const NurseCardVertical({
    Key? key,
    required this.nurse,
    this.onTap,
    this.width = 160,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final double rating = nurse.rating ?? 0.0;
    final int reviewCount = nurse.reviewCount ?? 0;
    final double cardHeight = width * (4 / 3);
    final double imageHeight = cardHeight * 0.5;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: cardHeight,
        margin: const EdgeInsets.only(right: TSizes.sm),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
          color: isDark ? TColors.dark : TColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nurse Image - Fills upper 50% of the card
            Container(
              height: imageHeight,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(TSizes.borderRadiusLg),
                  topRight: Radius.circular(TSizes.borderRadiusLg),
                ),
                image: DecorationImage(
                  image: nurse.profilePicUrl != null && nurse.profilePicUrl!.isNotEmpty
                      ? NetworkImage(nurse.profilePicUrl!)
                      : const AssetImage(TImages.user) as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  // Online Status Indicator
                  if (nurse.isActive)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isDark ? TColors.dark : TColors.white,
                            width: 2,
                          ),
                        ),
                      ),
                    ),

                  // Verified Badge
                  if (nurse.isVerified)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(TSizes.borderRadiusMd),
                        ),
                        child: const Icon(
                          Icons.verified,
                          color: Colors.white,
                          size: 12,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Nurse Details - Takes lower 50%
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(TSizes.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Name and Specialization
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name
                        Text(
                          nurse.fullName,
                          style: Theme.of(context).textTheme.titleMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),

                        // Specialization
                        if (nurse.specialization != null && nurse.specialization!.isNotEmpty)
                          Text(
                            nurse.specialization!,
                            style: Theme.of(context).textTheme.labelMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),

                    // Rating and Location - Reduced spacing
                    Column(
                      children: [
                        // Rating Row - Moved closer to name
                        Row(
                          children: [
                            Icon(
                              Iconsax.star1,
                              color: Colors.amber,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              rating.toStringAsFixed(1),
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            const SizedBox(width: 4),
                            if (reviewCount > 0)
                              Text(
                                '($reviewCount)',
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: TColors.grey,
                                ),
                              ),
                          ],
                        ),

                        const SizedBox(height: 2), // Reduced from 4 to 2

                        // Location
                        if (nurse.city != null || nurse.state != null)
                          Row(
                            children: [
                              Icon(
                                Iconsax.location,
                                color: TColors.grey,
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  "${nurse.city ?? ''}${nurse.city != null && nurse.state != null ? ', ' : ''}${nurse.state ?? ''}",
                                  style: Theme.of(context).textTheme.labelSmall,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}