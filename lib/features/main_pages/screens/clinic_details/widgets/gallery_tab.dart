// --------------------------
// Gallery Tab
// --------------------------

import 'package:flutter/material.dart';

import '../../../models/clinic_model.dart';

class ClinicGalleryTab extends StatelessWidget {
  final Clinic clinic;
  const ClinicGalleryTab({Key? key, required this.clinic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imgs = clinic.images;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        itemCount: imgs.length,
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8),
        itemBuilder: (_, i) => ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(imgs[i], fit: BoxFit.cover),
        ),
      ),
    );
  }
}
