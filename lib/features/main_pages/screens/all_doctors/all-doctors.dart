import 'package:flutter/material.dart';
import '../../../../common/widgets/doctors/doctor_card_horizontal.dart';
import '../../../../utils/constants/sizes.dart';

class AllDoctorsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> doctors;

  const AllDoctorsScreen({Key? key, required this.doctors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular doctors'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          final doctor = doctors[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
            child: TDoctorCardHorizontal(
              name: doctor['name']?.toString() ?? 'Unknown Doctor',
              specialty: doctor['specialty']?.toString() ?? 'Unknown Specialty',
              rating: (doctor['rating'] is num) ? (doctor['rating'] as num).toDouble() : 0.0,
              distance: doctor['distance']?.toString() ?? 'N/A',
              imageUrl: doctor['image']?.toString() ?? '',
            ),
          );
        },
      ),
    );
  }
}