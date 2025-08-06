import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/image_text_widget/vertical_image_text.dart';
import '../../clinic_list_page/clinic_list_page.dart';
import '../../doctors/Docotors_screen.dart';
import '../../emergencies/emergencies_map_page.dart';
import '../../nurse_page/nurse_page.dart';
import '../../pharmacy/pharmacy_screen.dart';

class THomeCategories extends StatelessWidget {
  const THomeCategories({super.key, required this.textColor});

  final Color textColor;

  @override
  Widget build(BuildContext context) {
    final specialties = <Map<String, dynamic>>[
      {
        'image': "assets/icons/services/Doctor.svg",
        'title': 'Doctors',
        'onTap': () {
          Get.to(() => const DoctorsScreen());
        },
      },
      {
        'image': "assets/icons/services/Pharmacy.svg",
        'title': 'Pharmacies',
        'onTap': () {
          Get.to(() => const PharmacyScreen());
        },
      },
      {
        'image': "assets/icons/services/Hospital.svg",
        'title': 'Clinics',
        'onTap': () {
          Get.to(() => ClinicListPage());
        },
      },
      {
        'image': "assets/icons/services/Ambulance.svg",
        'title': 'Emergencies',
        'onTap': () {
          Get.to(() => EmergenciesMapPage());
        },
      },
      {
        'image': "assets/icons/services/nurse.png",
        'title': 'Nurse',
        'onTap': () {
          Get.to(() => NursePage());
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