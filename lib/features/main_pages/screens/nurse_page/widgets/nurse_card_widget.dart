import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../../authentication/models/nurse_model.dart';

class NurseCard extends StatelessWidget {
  final NurseModel nurse;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onCardTap;
  final double? height; // Made optional; null for content-based sizing

  const NurseCard({
    Key? key,
    required this.nurse,
    this.margin,
    this.padding,
    this.onCardTap,
    this.height, // No default; pass explicitly if needed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDark = THelperFunctions.isDarkMode(context);
    final double rating = nurse.rating ?? 0.0;
    final int reviewCount = nurse.reviewCount ?? 0;
    final ImageProvider avatarImage = nurse.profilePicUrl != null && nurse.profilePicUrl!.isNotEmpty
        ? NetworkImage(nurse.profilePicUrl!)
        : const AssetImage(TImages.user) as ImageProvider;
    final Color cardColor = isDark ? TColors.dark : TColors.light;
    final Color textColor = isDark ? TColors.light : TColors.dark;
    final Color secondaryTextColor = isDark ? TColors.grey : Colors.grey[600]!;
    final Color tertiaryTextColor = isDark ? Colors.grey[400]! : Colors.grey[500]!;

    // Build the card content
    Widget cardContent = Container(
      margin: margin ?? const EdgeInsets.all(8),
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: TColors.primary.withOpacity(0.1), width: 0.5),
        boxShadow: [
          BoxShadow(
            color: TColors.primary.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // Ensures column shrinks to fit children
        children: [
          // Avatar with online indicator (assuming isActive)
          Stack(
            clipBehavior: Clip.none,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 32,
                  backgroundImage: avatarImage,
                  backgroundColor: TColors.primary.withOpacity(0.1),
                ),
              ),
              Positioned(
                bottom: -5,
                right: -5,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: nurse.isActive ? Colors.green : Colors.orange,
                    shape: BoxShape.circle,
                    border: Border.all(color: cardColor, width: 2),
                  ),
                  child: const Icon(
                    Iconsax.user,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Nurse Name and Specialization
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nurse.fullName,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: textColor,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              const SizedBox(height: 2),
              if (nurse.specialization != null && nurse.specialization!.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: TColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    nurse.specialization!,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: TColors.primary,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          // Enhanced Rating Row with icon
          Row(
            children: [
              Icon(Iconsax.star1, color: Colors.amber, size: 16),
              const SizedBox(width: 4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        for (int i = 0; i < 5; i++)
                          Icon(
                            i < rating.floor()
                                ? Icons.star
                                : (i < rating && rating % 1 >= 0.5)
                                ? Icons.star_half
                                : Icons.star_border,
                            color: Colors.amber,
                            size: 12,
                          ),
                        const SizedBox(width: 4),
                        Text(
                          rating.toStringAsFixed(1),
                          style: TextStyle(
                            color: secondaryTextColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (reviewCount > 0) ...[
                          const SizedBox(width: 2),
                          Text(
                            '($reviewCount)',
                            style: TextStyle(
                              color: tertiaryTextColor,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ],
                    ),
                    if (nurse.isVerified)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Iconsax.shield_tick, color: Colors.green, size: 12),
                          const SizedBox(width: 2),
                          Text(
                            'Verified',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Location with Icon
          Row(
            children: [
              Icon(Icons.location_on, color: tertiaryTextColor, size: 14),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  "${nurse.city ?? ''}${nurse.city != null && nurse.state != null ? ', ' : ''}${nurse.state ?? ''}",
                  style: TextStyle(
                    fontSize: 12,
                    color: secondaryTextColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          // Workplace or Age snippet
          if (nurse.workplace != null && nurse.workplace!.isNotEmpty)
            Row(
              children: [
                Icon(Iconsax.building, color: tertiaryTextColor, size: 14),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    nurse.workplace!,
                    style: TextStyle(
                      fontSize: 11,
                      color: tertiaryTextColor,
                      fontStyle: FontStyle.italic,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            )
          else if (nurse.age != null)
            Row(
              children: [
                Icon(Iconsax.user, color: tertiaryTextColor, size: 14),
                const SizedBox(width: 4),
                Text(
                  '${nurse.age} years old',
                  style: TextStyle(
                    fontSize: 11,
                    color: tertiaryTextColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
        ],
      ),
    );

    // Optionally wrap in SizedBox for fixed height if provided
    if (height != null) {
      cardContent = SizedBox(
        height: height,
        child: cardContent,
      );
    }

    return GestureDetector(
      onTap: onCardTap ?? () {},
      child: cardContent,
    );
  }
}