import 'package:medilink/features/main_pages/models/reviews_model.dart';
import 'doctor_model.dart';
import 'nurse_model.dart';
import 'service_model.dart';

class Clinic {
  final int beds;
  final String clinicName;
  final String clinicPic;
  final List<Doctor> doctors;
  final List<Nurse> nurses;
  final String description;
  final List<String> clinicSpecialty;
  final Map<String, dynamic> openingHours;
  final String address;
  final String city;
  final double latitude;
  final double longitude;
  final String website;
  final List<String> phoneNumbers; // Updated to a list to support multiple numbers.
  final String email; // New field added.
  final bool emergencyServices;
  final List<String> insuranceAccepted;
  final bool onlineAppointments;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Review> reviews; // New field for reviews
  final List<Service> services;
  final List<String> images; // List of image URLs


  Clinic({
    required this.clinicName,required this.beds,
    required this.clinicPic,
    required this.description,
    required this.clinicSpecialty,
    required this.openingHours,
    required this.address,
    required this.city,
    required this.latitude,
    required this.longitude,
    required this.website,
    required this.email,
    required this.emergencyServices,
    required this.insuranceAccepted,
    required this.onlineAppointments,
    required this.createdAt,
    required this.updatedAt,
    this.images = const [],
    this.reviews = const [],
    this.services = const [],
    this.phoneNumbers = const [],
    this.doctors = const [],
    this.nurses = const [],
  });
}
