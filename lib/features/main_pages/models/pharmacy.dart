
import 'package:medilink/features/main_pages/models/reviews_model.dart';

class Pharmacy {
  final String id;
  final String name;
  final String logoUrl;
  final String description;
  final List<String> specialties;
  final Map<String, dynamic> openingHours;
  final String address;
  final String city;
  final double latitude;
  final double longitude;
  final String website;
  final String email;
  final List<String> phoneNumbers;
  final bool emergencyServices;
  final List<String> insuranceAccepted;
  final bool onlineOrders;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String> images;
  final List<Review> reviews;

  Pharmacy({
    required this.id,
    required this.name,
    required this.logoUrl,
    required this.description,
    required this.specialties,
    required this.openingHours,
    required this.address,
    required this.city,
    required this.latitude,
    required this.longitude,
    required this.website,
    required this.email,
    required this.phoneNumbers,
    required this.emergencyServices,
    required this.insuranceAccepted,
    required this.onlineOrders,
    required this.createdAt,
    required this.updatedAt,
    this.images = const [],
    this.reviews = const [],
  });

  factory Pharmacy.fromJson(Map<String, dynamic> json) {
    return Pharmacy(
      id: json['id'],
      name: json['name'],
      logoUrl: json['logo_url'],
      description: json['description'],
      specialties: List<String>.from(json['specialties']),
      openingHours: Map<String, dynamic>.from(json['opening_hours']),
      address: json['address'],
      city: json['city'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      website: json['website'],
      email: json['email'],
      phoneNumbers: List<String>.from(json['phone_numbers']),
      emergencyServices: json['emergency_services'],
      insuranceAccepted: List<String>.from(json['insurance_accepted']),
      onlineOrders: json['online_orders'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      images: List<String>.from(json['images'] ?? []),
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => Review.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'logo_url': logoUrl,
    'description': description,
    'specialties': specialties,
    'opening_hours': openingHours,
    'address': address,
    'city': city,
    'latitude': latitude,
    'longitude': longitude,
    'website': website,
    'email': email,
    'phone_numbers': phoneNumbers,
    'emergency_services': emergencyServices,
    'insurance_accepted': insuranceAccepted,
    'online_orders': onlineOrders,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
    'images': images,
    'reviews': reviews.map((e) => e.toJson()).toList(),
  };
}
