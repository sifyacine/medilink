import 'reviews_model.dart';

class Nurse {
  final String fullName;
  final List<String> nursingSpecialties; // Areas of expertise, e.g. ICU, Pediatrics, etc.
  final String nursePic;
  final int age;
  final String address;
  final String city;
  final String state;
  final String bio;
  final int yearsOfExperience;
  final List<String> certifications; // e.g. BLS, ACLS, etc.
  final List<String> languagesSpoken;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Review> reviews; // Reviews for the nurse

  Nurse({
    required this.fullName,
    required this.nursingSpecialties,
    required this.nursePic,
    required this.age,
    required this.address,
    required this.city,
    required this.state,
    required this.bio,
    required this.yearsOfExperience,
    required this.certifications,
    required this.languagesSpoken,
    required this.createdAt,
    required this.updatedAt,
    this.reviews = const [],
  });
}
