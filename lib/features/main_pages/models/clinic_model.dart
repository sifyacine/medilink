import 'package:midilink/features/main_pages/models/reviews_model.dart';

import 'doctor_model.dart';

class Clinic {
  final String clinicName;
  final String clinicPic;
  final List<Doctor> doctors;
  final String description;
  final List<String> clinicSpecialty;
  final Map<String, dynamic> openingHours;
  final String address;
  final String city;
  final double latitude;
  final double longitude;
  final String website;
  final String phoneNumber;
  final bool emergencyServices;
  final List<String> insuranceAccepted;
  final bool onlineAppointments;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Review> reviews; // New field for reviews

  Clinic({
    required this.clinicName,
    required this.clinicPic,
    required this.doctors,
    required this.description,
    required this.clinicSpecialty,
    required this.openingHours,
    required this.address,
    required this.city,
    required this.latitude,
    required this.longitude,
    required this.website,
    required this.phoneNumber,
    required this.emergencyServices,
    required this.insuranceAccepted,
    required this.onlineAppointments,
    required this.createdAt,
    required this.updatedAt,
    this.reviews = const [],
  });
}
