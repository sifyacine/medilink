import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../../utils/formatters/formatter.dart';

class NurseModel {
  final String id;
  String firstName;
  String lastName;
  String username;
  String email;
  String phoneNumber;
  String? profilePicUrl;
  DateTime? dateOfBirth;
  String? city;
  String? state;
  String? licenseNumber;
  String? specialization;
  String? workplace;
  Map<String, dynamic>? emergencyContact; // Changed to dynamic for flexibility
  String? address;
  String role; // Made non-nullable with default value
  DateTime createdAt;
  DateTime updatedAt;
  bool isVerified;
  bool isActive;
  List<String>? certifications;
  List<String>? languages;
  String? bio;
  double? rating;
  int? reviewCount;
  Map<String, dynamic>? availability;
  List<String>? servicesOffered;

  NurseModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phoneNumber,
    this.profilePicUrl,
    this.dateOfBirth,
    this.city,
    this.state,
    this.licenseNumber,
    this.specialization,
    this.workplace,
    this.emergencyContact,
    this.address,
    this.role = 'nurse', // Default role
    DateTime? createdAt,
    DateTime? updatedAt,
    this.isVerified = false,
    this.isActive = true,
    this.certifications,
    this.languages,
    this.bio,
    this.rating,
    this.reviewCount = 0,
    this.availability,
    this.servicesOffered,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  // Factory constructor to create a NurseModel from a JSON map
  factory NurseModel.fromJson(Map<String, dynamic> json) {
    return NurseModel(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      profilePicUrl: json['profilePicUrl'] as String?,
      dateOfBirth: json['dateOfBirth'] != null ? DateTime.parse(json['dateOfBirth']) : null,
      city: json['city'] as String?,
      state: json['state'] as String?,
      licenseNumber: json['licenseNumber'] as String?,
      specialization: json['specialization'] as String?,
      workplace: json['workplace'] as String?,
      emergencyContact: json['emergencyContact'] != null ? Map<String, dynamic>.from(json['emergencyContact']) : null,
      address: json['address'] as String?,
      role: json['role'] as String? ?? 'nurse',
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      isVerified: json['isVerified'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? true,
      certifications: json['certifications'] != null ? List<String>.from(json['certifications']) : null,
      languages: json['languages'] != null ? List<String>.from(json['languages']) : null,
      bio: json['bio'] as String?,
      rating: json['rating'] != null ? (json['rating'] as num).toDouble() : null,
      reviewCount: json['reviewCount'] as int? ?? 0,
      availability: json['availability'] != null ? Map<String, dynamic>.from(json['availability']) : null,
      servicesOffered: json['servicesOffered'] != null ? List<String>.from(json['servicesOffered']) : null,
    );
  }

  // Factory constructor to create a NurseModel from a Firestore snapshot
  factory NurseModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return NurseModel.fromJson({...data, 'id': document.id});
  }

  // Convert to JSON for Firestore
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'profilePicUrl': profilePicUrl,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'city': city,
      'state': state,
      'licenseNumber': licenseNumber,
      'specialization': specialization,
      'workplace': workplace,
      'emergencyContact': emergencyContact,
      'address': address,
      'role': role,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'isVerified': isVerified,
      'isActive': isActive,
      'certifications': certifications,
      'languages': languages,
      'bio': bio,
      'rating': rating,
      'reviewCount': reviewCount,
      'availability': availability,
      'servicesOffered': servicesOffered,
    };
  }

  // Method to update timestamp before saving
  NurseModel copyWithUpdateTime() {
    return copyWith(updatedAt: DateTime.now());
  }

  // Copy with method for easy updates
  NurseModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? username,
    String? email,
    String? phoneNumber,
    ValueGetter<String?>? profilePicUrl,
    DateTime? dateOfBirth,
    String? city,
    String? state,
    String? licenseNumber,
    String? specialization,
    String? workplace,
    Map<String, dynamic>? emergencyContact,
    String? address,
    String? role,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isVerified,
    bool? isActive,
    List<String>? certifications,
    List<String>? languages,
    String? bio,
    double? rating,
    int? reviewCount,
    Map<String, dynamic>? availability,
    List<String>? servicesOffered,
  }) {
    return NurseModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePicUrl: profilePicUrl != null ? profilePicUrl() : this.profilePicUrl,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      city: city ?? this.city,
      state: state ?? this.state,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      specialization: specialization ?? this.specialization,
      workplace: workplace ?? this.workplace,
      emergencyContact: emergencyContact ?? this.emergencyContact,
      address: address ?? this.address,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isVerified: isVerified ?? this.isVerified,
      isActive: isActive ?? this.isActive,
      certifications: certifications ?? this.certifications,
      languages: languages ?? this.languages,
      bio: bio ?? this.bio,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      availability: availability ?? this.availability,
      servicesOffered: servicesOffered ?? this.servicesOffered,
    );
  }

  // Get full name
  String get fullName => '${firstName.trim()} ${lastName.trim()}';

  // Format phone number
  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

  // Get initial for avatar
  String get initial => firstName.isNotEmpty ? firstName[0].toUpperCase() : 'N';

  // Calculate age from date of birth
  int? get age {
    if (dateOfBirth == null) return null;
    final now = DateTime.now();
    int age = now.year - dateOfBirth!.year;
    if (now.month < dateOfBirth!.month ||
        (now.month == dateOfBirth!.month && now.day < dateOfBirth!.day)) {
      age--;
    }
    return age;
  }

  // Check if profile is complete
  bool get isProfileComplete {
    return firstName.isNotEmpty &&
        lastName.isNotEmpty &&
        email.isNotEmpty &&
        phoneNumber.isNotEmpty &&
        licenseNumber != null &&
        specialization != null;
  }

  // Get completion percentage
  double get profileCompletionPercentage {
    final requiredFields = [
      firstName,
      lastName,
      email,
      phoneNumber,
      licenseNumber,
      specialization,
      city,
      state,
      address,
    ];

    final completedFields = requiredFields.where((field) {
      if (field == null) return false;
      if (field is String) return field.isNotEmpty;
      return true;
    }).length;

    return completedFields / requiredFields.length;
  }

  // Split full name
  static List<String> nameParts(String fullName) => fullName.split(" ");

  // Generate username
  static String generateUsername(String fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    // Remove special characters and spaces
    String cleanFirstName = firstName.replaceAll(RegExp(r'[^a-z0-9]'), '');
    String cleanLastName = lastName.replaceAll(RegExp(r'[^a-z0-9]'), '');

    String camelCaseUsername = "$cleanFirstName$cleanLastName";
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return "nurse_${camelCaseUsername}_$timestamp";
  }

  // Create minimal nurse for registration
  static NurseModel createForRegistration({
    required String id,
    required String email,
    required String firstName,
    required String lastName,
    required String phoneNumber,
  }) {
    final fullName = '$firstName $lastName';
    return NurseModel(
      id: id,
      firstName: firstName,
      lastName: lastName,
      username: generateUsername(fullName),
      email: email,
      phoneNumber: phoneNumber,
      role: 'nurse',
      isVerified: false,
      isActive: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  // Empty nurse model
  static NurseModel empty() => NurseModel(
    id: '',
    firstName: '',
    lastName: '',
    username: '',
    email: '',
    phoneNumber: '',
  );

  // Override toString for easy debugging
  @override
  String toString() {
    return 'NurseModel{id: $id, firstName: $firstName, lastName: $lastName, username: $username, email: $email, '
        'phoneNumber: $phoneNumber, role: $role, isVerified: $isVerified, isActive: $isActive}';
  }

  // Override equality operators
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is NurseModel &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;
}