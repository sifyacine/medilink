

import 'package:midilink/features/main_pages/models/reviews_model.dart';

import 'clinic_model.dart';

class Doctor {
  final String fullName;
  final List<String> medicalSpecialty;
  final String doctorPic;
  final int age;
  final String address;
  final String city;
  final String state;
  final String bio;
  final List<Clinic> affiliatedClinics;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Review> reviews; // New field for reviews

  Doctor({
    required this.fullName,
    required this.medicalSpecialty,
    required this.doctorPic,
    required this.age,
    required this.address,
    required this.city,
    required this.state,
    required this.bio,
    required this.affiliatedClinics,
    required this.createdAt,
    required this.updatedAt,
    this.reviews = const [],
  });
}
