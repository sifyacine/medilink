import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/image_text_widget/vertical_image_text.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../doctors/Docotors_screen.dart';

class THomeCategories extends StatelessWidget {
  const THomeCategories({super.key, required this.textColor});

  final Color textColor;

  @override
  Widget build(BuildContext context) {
    final specialties = <Map<String, dynamic>>[
      {
        'image': TImages.doctor,
        'title': 'Doctors',
        'onTap': () {
          Get.to(() => const DoctorsScreen());
        },
      },
      {
        'image': TImages.pharmacy,
        'title': 'Pharmacies',
        'onTap': () {
          debugPrint('Pharmacies tapped');
        },
      },
      {
        'image': TImages.hospital,
        'title': 'Clinics',
        'onTap': () {
          debugPrint('Clinics tapped');
        },
      },
      {
        'image': TImages.ambulance,
        'title': 'Emergencies',
        'onTap': () {
          debugPrint('Emergencies tapped');
        },
      },
      {
        'image': TImages.nurse,
        'title': 'Nurse',
        'onTap': () {
          debugPrint('Nurse tapped');
        },
      },
    ];

    return SizedBox(
      height: 100,
      child: ListView.builder(
        itemCount: specialties.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final specialty = specialties[index];

          // Cast each field to its correct type
          final String image = specialty['image'] as String;
          final String title = specialty['title'] as String;
          final VoidCallback onTap = specialty['onTap'] as VoidCallback;

          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: TVerticalTextImage(
              textColor: textColor,
              image: image,
              title: title,
              onTap: onTap,
            ),
          );
        },
      ),
    );
  }
}
