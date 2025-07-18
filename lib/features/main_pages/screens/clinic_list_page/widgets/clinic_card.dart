import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink/features/main_pages/screens/clinic_list_page/widgets/star_rating.dart';
import 'package:medilink/utils/constants/colors.dart';
import 'package:medilink/utils/helpers/helper_functions.dart';

import '../../../models/clinic_model.dart';
import '../../clinic_details/clinic_details_page.dart';

/// Widget that represents a single clinic card.
class ClinicCard extends StatelessWidget {
  final Clinic clinic;

  const ClinicCard({Key? key, required this.clinic}) : super(key: key);

  double get averageRating {
    if (clinic.reviews.isEmpty) return 0.0;
    return clinic.reviews
        .map((r) => r.rating)
        .reduce((a, b) => a + b) /
        clinic.reviews.length;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () {
        Get.to(() => ClinicDetailsPage(clinic: clinic));
      },
      child: Card(
        color: isDark ? TColors.dark : TColors.light,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Clinic image on the left.
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                clinic.clinicPic,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),

            // Make the details expand to fill remaining space.
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name + one-star rating with numeric value on the left.
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            clinic.clinicName,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        StarRating(rating: averageRating),
                      ],
                    ),
                    const SizedBox(height: 4),

                    // Address line.
                    Text(
                      "${clinic.city}, ${clinic.address}",
                      style: TextStyle(
                        fontSize: 13,
                        color: isDark ? Colors.grey[400] : Colors.grey,
                      ),
                      overflow: TextOverflow.ellipsis,
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
