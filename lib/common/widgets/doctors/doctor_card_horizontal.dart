import 'package:flutter/material.dart';
import 'package:medilink/common/widgets/images/rounded_images.dart';

import '../../../../common/styles/shadows.dart';
import '../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';


class TDoctorCardHorizontal extends StatefulWidget {
  final String name;
  final String specialty;
  final double rating;
  final String distance;
  final String imageUrl;
  final VoidCallback? onTap;  // Changed from "CallBack" to "onTap" and made it optional

  const TDoctorCardHorizontal({
    Key? key,
    required this.name,
    required this.specialty,
    required this.rating,
    required this.distance,
    required this.imageUrl,
    this.onTap,  // Optional callback
  }) : super(key: key);

  @override
  _TDoctorCardHorizontalState createState() => _TDoctorCardHorizontalState();
}

class _TDoctorCardHorizontalState extends State<TDoctorCardHorizontal> {
  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: widget.onTap ?? () {
        print('Tapped on ${widget.name}');
      },
      child: Container(
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [TShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: isDark ? TColors.darkGrey : TColors.white,
        ),
        child: Row(
          children: [
            // Image Section
            TRoundedContainer(
              height: 150,
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: isDark ? TColors.dark : TColors.light,
              child: SizedBox(
                width: 130,
                height: 120,
                child: TRoundedImage(
                  imageUrl: widget.imageUrl,
                  applyImageRadius: true,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Doctor Information Section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Doctor's Name
                    Text(
                      widget.name,
                      style: Theme.of(context).textTheme.titleMedium ??
                          const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: TSizes.xs),
                    // Specialty
                    Text(
                      widget.specialty,
                      style: Theme.of(context).textTheme.bodyMedium ??
                          const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: TSizes.xs),
                    // Rating and Distance
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: TColors.secondary,
                          size: TSizes.iconSm,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.rating.toStringAsFixed(1),
                          style: Theme.of(context).textTheme.bodySmall ??
                              const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(width: 10),
                        Icon(
                          Icons.location_on,
                          color: TColors.secondary,
                          size: TSizes.iconSm,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.distance,
                          style: Theme.of(context).textTheme.bodySmall ??
                              const TextStyle(fontSize: 14),
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
