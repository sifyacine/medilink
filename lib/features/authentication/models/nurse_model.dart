import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/formatters/formatter.dart';

class NurseModel {
  final String id;
  String firstName;
  String lastName;
  final String username;
  final String email;
  String phoneNumber;
  String? profilePicUrl;
  DateTime? dateOfBirth;
  String? city;
  String? state;
  String? licenseNumber;
  String? specialization;
  String? workplace;
  Map<String, String>? emergencyContact;
  String? address;
  String? role; // Role field to identify as nurse

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
    this.role,
  });

  // Factory constructor to create a NurseModel from a JSON map
  factory NurseModel.fromJson(Map<String, dynamic> json) {
    return NurseModel(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      profilePicUrl: json['profile_pic_url'] as String?,
      dateOfBirth: json['date_of_birth'] != null ? DateTime.parse(json['date_of_birth']) : null,
      city: json['city'] as String?,
      state: json['state'] as String?,
      licenseNumber: json['license_number'] as String?,
      specialization: json['specialization'] as String?,
      workplace: json['workplace'] as String?,
      emergencyContact: json['emergency_contact'] != null ? Map<String, String>.from(json['emergency_contact']) : null,
      address: json['address'] as String?,
      role: json['role'] as String?,
    );
  }

  // Factory constructor to create a NurseModel from a Firestore snapshot
  factory NurseModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      return NurseModel(
        id: document.id,
        firstName: data['firstName'] ?? "",
        lastName: data['lastName'] ?? "",
        username: data['username'] ?? "",
        email: data['email'] ?? "",
        phoneNumber: data['phoneNumber'] ?? "",
        profilePicUrl: data['profile_pic_url'] as String?,
        dateOfBirth: data['date_of_birth'] != null ? DateTime.parse(data['date_of_birth']) : null,
        city: data['city'] as String?,
        state: data['state'] as String?,
        licenseNumber: data['license_number'] as String?,
        specialization: data['specialization'] as String?,
        workplace: data['workplace'] as String?,
        emergencyContact: data['emergency_contact'] != null ? Map<String, String>.from(data['emergency_contact']) : null,
        address: data['address'] as String?,
        role: data['role'] as String?,
      );
    } else {
      throw Exception('Document data is null');
    }
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
      'profile_pic_url': profilePicUrl,
      'date_of_birth': dateOfBirth?.toIso8601String(),
      'city': city,
      'state': state,
      'license_number': licenseNumber,
      'specialization': specialization,
      'workplace': workplace,
      'emergency_contact': emergencyContact,
      'address': address,
      'role': role,
    };
  }

  // Get full name
  String get fullName => '${firstName.trim()} ${lastName.trim()}';

  // Format phone number
  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

  // Split full name
  static List<String> nameParts(String fullName) => fullName.split(" ");

  // Generate username
  static String generateUsername(String fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";
    String camelCaseUsername = "$firstName$lastName";
    return "nurse_$camelCaseUsername";
  }

  // Empty nurse model
  static NurseModel empty() => NurseModel(
    id: '',
    firstName: '',
    lastName: '',
    username: '',
    email: '',
    phoneNumber: '',
    profilePicUrl: '',
    role: null,
  );

  // Override toString for easy debugging
  @override
  String toString() {
    return 'NurseModel{id: $id, firstName: $firstName, lastName: $lastName, username: $username, email: $email, phoneNumber: $phoneNumber, '
        'profilePicUrl: $profilePicUrl, dateOfBirth: $dateOfBirth, city: $city, state: $state, '
        'licenseNumber: $licenseNumber, specialization: $specialization, workplace: $workplace, '
        'emergencyContact: $emergencyContact, address: $address, role: $role}';
  }
}