import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../models/nurse_model.dart';

class NurseCard extends StatelessWidget {
  final Nurse nurse;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onCardTap;


  const NurseCard({
    Key? key,
    required this.nurse,
    this.margin,
    this.padding, this.onCardTap,
  }) : super(key: key);

  double get averageRating {
    if (nurse.reviews.isEmpty) return 0.0;
    return nurse.reviews
        .map((r) => r.rating)
        .reduce((a, b) => a + b) /
        nurse.reviews.length;
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onCardTap ?? () {},
      child: Card(
        elevation: 0,
        color: isDark ? TColors.dark : TColors.light,
        margin: margin ?? const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Centered Avatar
              Center(
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: nurse.nursePic.isNotEmpty
                      ? AssetImage(nurse.nursePic)
                      : const AssetImage(TImages.user),
                ),
              ),
              const SizedBox(height: 8),
              // Nurse Name
              Text(
                nurse.fullName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              const SizedBox(height: 4),
              // 5-Star Rating Bar
              Row(
                children: [
                  for (int i = 0; i < 5; i++)
                    Icon(
                      i < averageRating.floor()
                          ? Icons.star
                          : (i < averageRating && averageRating % 1 >= 0.5)
                          ? Icons.star_half
                          : Icons.star_border,
                      color: Colors.amber,
                      size: 14,
                    ),
                  const SizedBox(width: 4),
                  Text(
                    averageRating.toStringAsFixed(1),
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Address (City, State)
              Text(
                "${nurse.city}, ${nurse.state}",
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
