import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum DeplacementType { oneTime, daily, weekly, monthly }

/// Helper functions to convert TimeOfDay to/from a Map for Firestore.
Map<String, dynamic> timeOfDayToMap(TimeOfDay time) {
  return {
    'hour': time.hour,
    'minute': time.minute,
  };
}

TimeOfDay timeOfDayFromMap(Map<String, dynamic> map) {
  return TimeOfDay(
    hour: map['hour'] ?? 0,
    minute: map['minute'] ?? 0,
  );
}

class Announcement {
  String uid;
  String publisherId;
  int views;
  DateTime startDate;
  DateTime? endDate; // For recurring services
  String additionalNotes;
  String state;
  String city;
  TimeOfDay startTime;
  TimeOfDay endTime;

  // Location fields (for pickup/drop-off if needed)
  String? startingPoint;
  String? endingPoint;

  // Service frequency
  DeplacementType? deplacementType;
  int? deplacementFrequency; // Number of times per period

  // Target audience specification
  String targetAudience; // "Children", "Elderly", "Disabled", "All", etc.
  int? minAge;
  int? maxAge;

  // System fields
  DateTime createdAt;
  DateTime updatedAt;
  bool isActive;
  String status; // "Pending", "Approved", "Active", "Completed", "Cancelled"

  Announcement({
    required this.uid,
    required this.publisherId,
    this.views = 0,
    required this.startDate,
    this.endDate,
    required this.additionalNotes,
    required this.state,
    required this.city,
    required this.startTime,
    required this.endTime,
    this.startingPoint,
    this.endingPoint,
    this.deplacementType,
    this.deplacementFrequency,
    required this.targetAudience,
    this.minAge,
    this.maxAge,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.isActive = true,
    this.status = "Pending",
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  /// Convert an Announcement instance into a Map for Firestore.
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'publisherId': publisherId,
      'views': views,
      'startDate': Timestamp.fromDate(startDate),
      'endDate': endDate != null ? Timestamp.fromDate(endDate!) : null,
      'additionalNotes': additionalNotes,
      'state': state,
      'city': city,
      'startTime': timeOfDayToMap(startTime),
      'endTime': timeOfDayToMap(endTime),
      'startingPoint': startingPoint,
      'endingPoint': endingPoint,
      'deplacementType': deplacementType?.toString(),
      'deplacementFrequency': deplacementFrequency,
      'targetAudience': targetAudience,
      'minAge': minAge,
      'maxAge': maxAge,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'isActive': isActive,
      'status': status,
    };
  }

  /// Create an Announcement instance from a Firestore document.
  factory Announcement.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Announcement(
      uid: data['uid'] ?? doc.id,
      publisherId: data['publisherId'] ?? '',
      views: data['views'] ?? 0,
      startDate: (data['startDate'] as Timestamp).toDate(),
      endDate: data['endDate'] != null ? (data['endDate'] as Timestamp).toDate() : null,
      additionalNotes: data['additionalNotes'] ?? '',
      state: data['state'] ?? '',
      city: data['city'] ?? '',
      startTime: timeOfDayFromMap(Map<String, dynamic>.from(data['startTime'] ?? {'hour': 0, 'minute': 0})),
      endTime: timeOfDayFromMap(Map<String, dynamic>.from(data['endTime'] ?? {'hour': 0, 'minute': 0})),
      startingPoint: data['startingPoint'],
      endingPoint: data['endingPoint'],
      deplacementType: data['deplacementType'] != null
          ? DeplacementType.values.firstWhere(
            (e) => e.toString() == data['deplacementType'],
        orElse: () => DeplacementType.oneTime,
      )
          : null,
      deplacementFrequency: data['deplacementFrequency'],
      targetAudience: data['targetAudience'] ?? 'All',
      minAge: data['minAge'],
      maxAge: data['maxAge'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
      isActive: data['isActive'] ?? true,
      status: data['status'] ?? "Pending",
    );
  }

  /// Empty announcement model
  static Announcement empty() => Announcement(
    uid: '',
    publisherId: '',
    startDate: DateTime.now(),
    additionalNotes: '',
    state: '',
    city: '',
    startTime: const TimeOfDay(hour: 0, minute: 0),
    endTime: const TimeOfDay(hour: 0, minute: 0),
    targetAudience: 'All',
    isActive: false,
    status: 'Pending',
  );
}