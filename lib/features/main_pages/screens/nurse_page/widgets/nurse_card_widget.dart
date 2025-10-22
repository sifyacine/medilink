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
  final double? height;
  final double? width;

  const NurseCard({
    Key? key,
    required this.nurse,
    this.margin,
    this.padding,
    this.onCardTap,
    this.height,
    this.width,
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

    return Container(
      margin: margin ?? const EdgeInsets.all(8),
      width: width, // Allow width control
      height: height, // Allow height control
      child: GestureDetector(
        onTap: onCardTap,
        child: Container(
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
          child: LayoutBuilder(
            builder: (context, constraints) {
              final bool isCompact = constraints.maxHeight < 200 || constraints.maxWidth < 160;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Avatar with online indicator - responsive sizing
                  Center(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CircleAvatar(
                          radius: isCompact ? 24 : 32,
                          backgroundImage: avatarImage,
                          backgroundColor: TColors.primary.withOpacity(0.1),
                        ),
                        Positioned(
                          bottom: isCompact ? -4 : -5,
                          right: isCompact ? -4 : -5,
                          child: Container(
                            padding: EdgeInsets.all(isCompact ? 3 : 4),
                            decoration: BoxDecoration(
                              color: nurse.isActive ? Colors.green : Colors.orange,
                              shape: BoxShape.circle,
                              border: Border.all(color: cardColor, width: 2),
                            ),
                            child: Icon(
                              Iconsax.user,
                              color: Colors.white,
                              size: isCompact ? 10 : 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: isCompact ? 8 : 12),

                  // Nurse Name and Specialization
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nurse.fullName,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: isCompact ? 14 : 16,
                          color: textColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      SizedBox(height: isCompact ? 2 : 4),
                      if (nurse.specialization != null && nurse.specialization!.isNotEmpty)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: isCompact ? 6 : 8,
                            vertical: isCompact ? 2 : 4,
                          ),
                          decoration: BoxDecoration(
                            color: TColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            nurse.specialization!,
                            style: TextStyle(
                              fontSize: isCompact ? 10 : 12,
                              fontWeight: FontWeight.w500,
                              color: TColors.primary,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: isCompact ? 6 : 8),

                  // Rating Row
                  Row(
                    children: [
                      Icon(Iconsax.star1, color: Colors.amber, size: isCompact ? 14 : 16),
                      SizedBox(width: isCompact ? 2 : 4),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                ...List.generate(5, (i) {
                                  IconData icon;
                                  if (i < rating.floor()) {
                                    icon = Icons.star;
                                  } else if (i < rating && rating % 1 >= 0.5) {
                                    icon = Icons.star_half;
                                  } else {
                                    icon = Icons.star_border;
                                  }
                                  return Icon(icon, color: Colors.amber, size: isCompact ? 10 : 12);
                                }),
                                SizedBox(width: isCompact ? 2 : 4),
                                Text(
                                  rating.toStringAsFixed(1),
                                  style: TextStyle(
                                    color: secondaryTextColor,
                                    fontSize: isCompact ? 10 : 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                if (reviewCount > 0) ...[
                                  SizedBox(width: isCompact ? 1 : 2),
                                  Text(
                                    '($reviewCount)',
                                    style: TextStyle(
                                      color: tertiaryTextColor,
                                      fontSize: isCompact ? 8 : 10,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            if (nurse.isVerified)
                              Padding(
                                padding: EdgeInsets.only(top: isCompact ? 2 : 4),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Iconsax.shield_tick, color: Colors.green, size: isCompact ? 10 : 12),
                                    SizedBox(width: isCompact ? 1 : 2),
                                    Text(
                                      'Verified',
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: isCompact ? 8 : 10,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Spacer to push location to bottom in fixed height scenarios
                  if (height != null) Expanded(child: Container()),

                  SizedBox(height: isCompact ? 6 : 8),

                  // Location
                  Row(
                    children: [
                      Icon(Icons.location_on, color: tertiaryTextColor, size: isCompact ? 12 : 14),
                      SizedBox(width: isCompact ? 2 : 4),
                      Expanded(
                        child: Text(
                          "${nurse.city ?? ''}${nurse.city != null && nurse.state != null ? ', ' : ''}${nurse.state ?? ''}",
                          style: TextStyle(
                            fontSize: isCompact ? 10 : 12,
                            color: secondaryTextColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: isCompact ? 2 : 4),

                  // Workplace or Age
                  if (nurse.workplace != null && nurse.workplace!.isNotEmpty)
                    Row(
                      children: [
                        Icon(Iconsax.building, color: tertiaryTextColor, size: isCompact ? 12 : 14),
                        SizedBox(width: isCompact ? 2 : 4),
                        Expanded(
                          child: Text(
                            nurse.workplace!,
                            style: TextStyle(
                              fontSize: isCompact ? 9 : 11,
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
                        Icon(Iconsax.user, color: tertiaryTextColor, size: isCompact ? 12 : 14),
                        SizedBox(width: isCompact ? 2 : 4),
                        Text(
                          '${nurse.age} years old',
                          style: TextStyle(
                            fontSize: isCompact ? 9 : 11,
                            color: tertiaryTextColor,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}