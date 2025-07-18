import 'package:flutter/material.dart';
import '../../../../common/widgets/doctors/doctor_card_horizontal.dart';
import '../../../../utils/constants/sizes.dart';
import '../../models/doctor_model.dart';
import '../../models/reviews_model.dart'; // Add model import

class AllDoctorsScreen extends StatelessWidget {
  final List<Doctor> doctors; // Changed to List<Doctor>

  const AllDoctorsScreen({Key? key, required this.doctors}) : super(key: key);

  double _calculateAverageRating(List<Review> reviews) {
    if (reviews.isEmpty) return 4.5;
    final total = reviews.fold(0.0, (sum, review) => sum + review.rating);
    return total / reviews.length;
  }

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
              name: doctor.fullName,
              specialty: doctor.medicalSpecialty.join(', '),
              rating: _calculateAverageRating(doctor.reviews),
              distance: '1 km', // Add distance to Doctor model
              imageUrl: doctor.doctorPic,
            ),
          );
        },
      ),
    );
  }
}