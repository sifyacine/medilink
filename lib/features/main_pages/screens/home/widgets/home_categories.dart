import 'package:flutter/material.dart';
import '../../../../../common/widgets/image_text_widget/vertical_image_text.dart';
import '../../../../../utils/constants/image_strings.dart';

class THomeCategories extends StatelessWidget {
  const THomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    // Define your specialties with unique images and titles
    final specialties = [
      {'image': TImages.doctor, 'title': 'Doctors'},
      {'image': TImages.pharmacy, 'title': 'Pharmacies'},
      {'image': TImages.hospital, 'title': 'Clinics'},
      {'image': TImages.ambulance, 'title': 'emergencies'},
      {'image': TImages.nurse, 'title': 'nurse'},
    ];

    return SizedBox(
      height: 100,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: specialties.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final specialty = specialties[index];
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: TVerticalTextImage(
              image: specialty['image']!,
              title: specialty['title']!,
              onTap: () {
                // Add onTap functionality for this specialty if needed.
              },
            ),
          );
        },
      ),
    );
  }
}
