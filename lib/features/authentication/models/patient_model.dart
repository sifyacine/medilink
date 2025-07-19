import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/formatters/formatter.dart';

class UserModel {
  final String id;
  String firstName;
  String lastName;
  final String username;
  final String email;
  String phoneNumber;
  String? medicalFolderUrl;
  String? profilePicUrl;
  DateTime? dateOfBirth;
  String? city;
  String? state;
  String? description;
  String? bloodType;
  String? gender;
  Map<String, String>? emergencyContact;
  String? address;
  String? role; // Added role field

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phoneNumber,
    this.medicalFolderUrl,
    this.profilePicUrl,
    this.dateOfBirth,
    this.city,
    this.state,
    this.description,
    this.bloodType,
    this.gender,
    this.emergencyContact,
    this.address,
    this.role, // Added to constructor
  });

  // Factory constructor to create a UserModel from a JSON map (for Supabase)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      medicalFolderUrl: json['medical_folder_url'] as String?,
      profilePicUrl: json['profile_pic_url'] as String?,
      dateOfBirth: json['date_of_birth'] != null ? DateTime.parse(json['date_of_birth']) : null,
      city: json['city'] as String?,
      state: json['state'] as String?,
      description: json['description'] as String?,
      bloodType: json['blood_type'] as String?,
      gender: json['gender'] as String?,
      emergencyContact: json['emergency_contact'] != null ? Map<String, String>.from(json['emergency_contact']) : null,
      address: json['address'] as String?,
      role: json['role'] as String?, // Added role mapping
    );
  }

  // Factory constructor to create a UserModel from a Firestore snapshot
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      return UserModel(
        id: document.id,
        firstName: data['firstName'] ?? "",
        lastName: data['lastName'] ?? "",
        username: data['username'] ?? "",
        email: data['email'] ?? "",
        phoneNumber: data['phoneNumber'] ?? "",
        medicalFolderUrl: data['medical_folder_url'] as String?,
        profilePicUrl: data['profile_pic_url'] as String?,
        dateOfBirth: data['date_of_birth'] != null ? DateTime.parse(data['date_of_birth']) : null,
        city: data['city'] as String?,
        state: data['state'] as String?,
        description: data['description'] as String?,
        bloodType: data['blood_type'] as String?,
        gender: data['gender'] as String?,
        emergencyContact: data['emergency_contact'] != null ? Map<String, String>.from(data['emergency_contact']) : null,
        address: data['address'] as String?,
        role: data['role'] as String?, // Added role mapping
      );
    } else {
      throw Exception('Document data is null');
    }
  }

  // Convert to JSON for Supabase
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'medical_folder_url': medicalFolderUrl,
      'profile_pic_url': profilePicUrl,
      'date_of_birth': dateOfBirth?.toIso8601String(),
      'city': city,
      'state': state,
      'description': description,
      'blood_type': bloodType,
      'gender': gender,
      'emergency_contact': emergencyContact,
      'address': address,
      'role': role, // Added role to JSON
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
    return "cwt_$camelCaseUsername";
  }

  // Empty user model
  static UserModel empty() => UserModel(
    id: '',
    firstName: '',
    lastName: '',
    username: '',
    email: '',
    phoneNumber: '',
    profilePicUrl: '',
    role: null, // Added to empty model
  );

  // Override toString for easy debugging
  @override
  String toString() {
    return 'UserModel{id: $id, firstName: $firstName, lastName: $lastName, username: $username, email: $email, phoneNumber: $phoneNumber, '
        'medicalFolderUrl: $medicalFolderUrl, profilePicUrl: $profilePicUrl, dateOfBirth: $dateOfBirth, city: $city, state: $state, '
        'description: $description, bloodType: $bloodType, gender: $gender, emergencyContact: $emergencyContact, address: $address, role: $role}';
  }
}