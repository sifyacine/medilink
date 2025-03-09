import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:midilink/utils/constants/colors.dart';
import 'package:midilink/utils/helpers/helper_functions.dart';
import '../../../../../common/widgets/image_text_widget/vertical_image_text.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../controllers/doctors_specialties_controller.dart';

class TDoctorsSpecialties extends StatelessWidget {
  TDoctorsSpecialties({Key? key}) : super(key: key);

  // Use Get.find to reuse the existing controller instance
  final controller = Get.put(DoctorsSpecialtiesController());

  // List of 19 specialties with images and names from TImages
  final List<Map<String, dynamic>> specialties = [
    {
      'image': TImages.generalPractitioner,
      'title': 'General Practitioner',
      'onTap': () {
        debugPrint('General Practitioner tapped');
      },
    },
    {
      'image': TImages.pulmonologist,
      'title': 'Pulmonologist',
      'onTap': () {
        debugPrint('Pulmonologist tapped');
      },
    },
    {
      'image': TImages.dentist,
      'title': 'Dentist',
      'onTap': () {
        debugPrint('Dentist tapped');
      },
    },
    {
      'image': TImages.psychiatrist,
      'title': 'Psychiatrist',
      'onTap': () {
        debugPrint('Psychiatrist tapped');
      },
    },
    {
      'image': TImages.neurologist,
      'title': 'Neurologist',
      'onTap': () {
        debugPrint('Neurologist tapped');
      },
    },
    {
      'image': TImages.surgeon,
      'title': 'Surgeon',
      'onTap': () {
        debugPrint('Surgeon tapped');
      },
    },
    {
      'image': TImages.cardiologist,
      'title': 'Cardiologist',
      'onTap': () {
        debugPrint('Cardiologist tapped');
      },
    },
    {
      'image': TImages.pediatrician,
      'title': 'Pediatrician',
      'onTap': () {
        debugPrint('Pediatrician tapped');
      },
    },
    {
      'image': TImages.dermatologist,
      'title': 'Dermatologist',
      'onTap': () {
        debugPrint('Dermatologist tapped');
      },
    },
    {
      'image': TImages.oncologist,
      'title': 'Oncologist',
      'onTap': () {
        debugPrint('Oncologist tapped');
      },
    },
    {
      'image': TImages.optician,
      'title': 'Optician',
      'onTap': () {
        debugPrint('Optician tapped');
      },
    },
    {
      'image': TImages.gynecologist,
      'title': 'Gynecologist',
      'onTap': () {
        debugPrint('Gynecologist tapped');
      },
    },
    {
      'image': TImages.endocrinologist,
      'title': 'Endocrinologist',
      'onTap': () {
        debugPrint('Endocrinologist tapped');
      },
    },
    {
      'image': TImages.rheumatologist,
      'title': 'Rheumatologist',
      'onTap': () {
        debugPrint('Rheumatologist tapped');
      },
    },
    {
      'image': TImages.orthopedist,
      'title': 'Orthopedist',
      'onTap': () {
        debugPrint('Orthopedist tapped');
      },
    },
    {
      'image': TImages.ophthalmologist,
      'title': 'Ophthalmologist',
      'onTap': () {
        debugPrint('Ophthalmologist tapped');
      },
    },
    {
      'image': TImages.urologist,
      'title': 'Urologist',
      'onTap': () {
        debugPrint('Urologist tapped');
      },
    },
    {
      'image': TImages.gastroenterologist,
      'title': 'Gastroenterologist',
      'onTap': () {
        debugPrint('Gastroenterologist tapped');
      },
    },
    {
      'image': TImages.nephrologist,
      'title': 'Nephrologist',
      'onTap': () {
        debugPrint('Nephrologist tapped');
      },
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return Obx(() {
      final itemsToShow = controller.isExpanded.value
          ? specialties
          : specialties.take(5).toList(); // Show first 5 when not expanded
      return GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemsToShow.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          childAspectRatio: 0.75,
        ),
        itemBuilder: (context, index) {
          final specialty = itemsToShow[index];
          return TVerticalTextImage(
            textColor: isDark? TColors.white: TColors.black,
            image: specialty['image'],
            title: specialty['title'],
            onTap: specialty['onTap'],
          );
        },
      );
    });
  }
}
