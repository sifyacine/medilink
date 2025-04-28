import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/image_text_widget/vertical_image_text.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../clinic_list_page/clinic_list_page.dart';
import '../../doctors/Docotors_screen.dart';
import '../../emergencies/emergencies_map_page.dart';
import '../../pharmacy/pharmacy_screen.dart';

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
          Get.to(() => const PharmacyScreen());
        },
      },
      {
        'image': TImages.hospital,
        'title': 'Clinics',
        'onTap': () {
          Get.to(() => ClinicListPage());
        },
      },
      {
        'image': TImages.ambulance,
        'title': 'Emergencies',
        'onTap': () {
          Get.to(() => EmergenciesMapPage());
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
