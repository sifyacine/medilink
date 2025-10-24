import 'package:cloud_firestore/cloud_firestore.dart';

enum ReservationStatus {
  pending,      // Nurse sent offer, waiting patient approval
  accepted,     // Patient accepted the offer
  confirmed,    // Nurse confirmed and can see location
  inProgress,   // Service started
  completed,    // Service completed
  cancelled,    // Cancelled by either party
  rejected      // Patient rejected the offer
}

class Reservation {
  String id;
  String announcementId;
  String patientId;
  String nurseId;

  // Offer details
  double proposedPrice;
  String nurseNotes;
  String? patientNotes;

  // Status management
  ReservationStatus status;
  DateTime createdAt;
  DateTime updatedAt;

  // Location access control
  bool canNurseSeeLocation;
  bool locationConfirmedByNurse;

  // Rating flags
  bool patientRated;
  bool nurseRated;

  Reservation({
    required this.id,
    required this.announcementId,
    required this.patientId,
    required this.nurseId,
    required this.proposedPrice,
    required this.nurseNotes,
    this.patientNotes,
    required this.status,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.canNurseSeeLocation = false,
    this.locationConfirmedByNurse = false,
    this.patientRated = false,
    this.nurseRated = false,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'announcementId': announcementId,
      'patientId': patientId,
      'nurseId': nurseId,
      'proposedPrice': proposedPrice,
      'nurseNotes': nurseNotes,
      'patientNotes': patientNotes,
      'status': status.toString(),
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'canNurseSeeLocation': canNurseSeeLocation,
      'locationConfirmedByNurse': locationConfirmedByNurse,
      'patientRated': patientRated,
      'nurseRated': nurseRated,
    };
  }

  factory Reservation.fromDocument(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return Reservation(
      id: data['id'] ?? document.id,
      announcementId: data['announcementId'] ?? '',
      patientId: data['patientId'] ?? '',
      nurseId: data['nurseId'] ?? '',
      proposedPrice: (data['proposedPrice'] ?? 0.0).toDouble(),
      nurseNotes: data['nurseNotes'] ?? '',
      patientNotes: data['patientNotes'],
      status: ReservationStatus.values.firstWhere(
            (e) => e.toString() == data['status'],
        orElse: () => ReservationStatus.pending,
      ),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
      canNurseSeeLocation: data['canNurseSeeLocation'] ?? false,
      locationConfirmedByNurse: data['locationConfirmedByNurse'] ?? false,
      patientRated: data['patientRated'] ?? false,
      nurseRated: data['nurseRated'] ?? false,
    );
  }

  // Helper methods for status transitions
  bool get canPatientAccept => status == ReservationStatus.pending;
  bool get canPatientReject => status == ReservationStatus.pending;
  bool get canNurseConfirmLocation => status == ReservationStatus.accepted && canNurseSeeLocation;
  bool get canStartService => status == ReservationStatus.confirmed && locationConfirmedByNurse;
  bool get canComplete => status == ReservationStatus.inProgress;
  bool get canRate => status == ReservationStatus.completed;

  // Empty reservation
  static Reservation empty() => Reservation(
    id: '',
    announcementId: '',
    patientId: '',
    nurseId: '',
    proposedPrice: 0.0,
    nurseNotes: '',
    status: ReservationStatus.pending,
  );
}