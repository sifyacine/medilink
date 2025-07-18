
// --------------------------
// Review Tab
// --------------------------

import 'package:flutter/material.dart';
import 'package:medilink/utils/constants/colors.dart';
import 'package:medilink/utils/helpers/helper_functions.dart';

import '../../../models/clinic_model.dart';

class ClinicReviewTab extends StatelessWidget {
  final Clinic clinic;
  const ClinicReviewTab({Key? key, required this.clinic})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    if (clinic.reviews.isEmpty) {
      return const Center(child: Text("No reviews available."));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: clinic.reviews.length,
      itemBuilder: (_, i) {
        final r = clinic.reviews[i];
        return Card(
          color: isDark? TColors.dark: TColors.light,
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading:
            const Icon(Icons.star, color: Colors.amber),
            title: Text(r.rating.toStringAsFixed(1)),
            subtitle: Text(r.comment),
            trailing: Text(
                "${r.createdAt.month}/${r.createdAt.day}/${r.createdAt.year}"),
          ),
        );
      },
    );
  }
}
