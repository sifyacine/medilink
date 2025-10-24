import 'package:cloud_firestore/cloud_firestore.dart';

import '../../features/main_pages/models/rating_model.dart';
import '../../features/main_pages/models/reservation_model.dart';

class ReservationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Nurse creates an offer for an announcement
  Future<Reservation> createOffer({
    required String announcementId,
    required String patientId,
    required String nurseId,
    required double proposedPrice,
    required String nurseNotes,
  }) async {
    final reservation = Reservation(
      id: _firestore.collection('reservations').doc().id,
      announcementId: announcementId,
      patientId: patientId,
      nurseId: nurseId,
      proposedPrice: proposedPrice,
      nurseNotes: nurseNotes,
      status: ReservationStatus.pending,
    );

    await _firestore
        .collection('reservations')
        .doc(reservation.id)
        .set(reservation.toJson());

    return reservation;
  }

  // Patient accepts an offer
  Future<void> acceptOffer(String reservationId, String patientNotes) async {
    await _firestore.collection('reservations').doc(reservationId).update({
      'status': ReservationStatus.accepted.toString(),
      'patientNotes': patientNotes,
      'canNurseSeeLocation': true,
      'updatedAt': Timestamp.now(),
    });
  }

  // Patient rejects an offer
  Future<void> rejectOffer(String reservationId, String patientNotes) async {
    await _firestore.collection('reservations').doc(reservationId).update({
      'status': ReservationStatus.rejected.toString(),
      'patientNotes': patientNotes,
      'updatedAt': Timestamp.now(),
    });
  }

  // Nurse confirms location and can proceed
  Future<void> confirmLocation(String reservationId) async {
    await _firestore.collection('reservations').doc(reservationId).update({
      'status': ReservationStatus.confirmed.toString(),
      'locationConfirmedByNurse': true,
      'updatedAt': Timestamp.now(),
    });
  }

  // Start the service
  Future<void> startService(String reservationId) async {
    await _firestore.collection('reservations').doc(reservationId).update({
      'status': ReservationStatus.inProgress.toString(),
      'updatedAt': Timestamp.now(),
    });
  }

  // Complete the service
  Future<void> completeService(String reservationId) async {
    await _firestore.collection('reservations').doc(reservationId).update({
      'status': ReservationStatus.completed.toString(),
      'updatedAt': Timestamp.now(),
    });
  }

  // Get reservations for a patient
  Stream<List<Reservation>> getPatientReservations(String patientId) {
    return _firestore
        .collection('reservations')
        .where('patientId', isEqualTo: patientId)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Reservation.fromDocument(doc))
        .toList());
  }

  // Get offers for a nurse
  Stream<List<Reservation>> getNurseReservations(String nurseId) {
    return _firestore
        .collection('reservations')
        .where('nurseId', isEqualTo: nurseId)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Reservation.fromDocument(doc))
        .toList());
  }

  // Get specific reservation
  Stream<Reservation> getReservation(String reservationId) {
    return _firestore
        .collection('reservations')
        .doc(reservationId)
        .snapshots()
        .map((doc) => Reservation.fromDocument(doc));
  }
}

class RatingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Rating> createRating({
    required String reservationId,
    required String ratedUserId,
    required String raterUserId,
    required int rating,
    required String comment,
    required String ratedUserRole,
    required String raterUserRole,
  }) async {
    final ratingDoc = Rating(
      id: _firestore.collection('ratings').doc().id,
      reservationId: reservationId,
      ratedUserId: ratedUserId,
      raterUserId: raterUserId,
      rating: rating,
      comment: comment,
      ratedUserRole: ratedUserRole,
      raterUserRole: raterUserRole,
    );

    await _firestore
        .collection('ratings')
        .doc(ratingDoc.id)
        .set(ratingDoc.toJson());

    // Update reservation rating flags
    final reservationRef = _firestore.collection('reservations').doc(reservationId);

    if (raterUserRole == 'patient') {
      await reservationRef.update({'patientRated': true});
    } else if (raterUserRole == 'nurse') {
      await reservationRef.update({'nurseRated': true});
    }

    // Update user's rating statistics
    await _updateUserRating(ratedUserId, ratedUserRole);

    return ratingDoc;
  }

  Future<void> _updateUserRating(String userId, String userRole) async {
    final ratingsSnapshot = await _firestore
        .collection('ratings')
        .where('ratedUserId', isEqualTo: userId)
        .where('ratedUserRole', isEqualTo: userRole)
        .get();

    if (ratingsSnapshot.docs.isNotEmpty) {
      final totalRating = ratingsSnapshot.docs
          .map((doc) => Rating.fromDocument(doc).rating)
          .reduce((a, b) => a + b);

      final averageRating = totalRating / ratingsSnapshot.docs.length;

      // Update in the appropriate collection based on user role
      if (userRole == 'nurse') {
        await _firestore.collection('nurses').doc(userId).update({
          'rating': averageRating,
          'reviewCount': ratingsSnapshot.docs.length,
        });
      } else if (userRole == 'patient') {
        await _firestore.collection('users').doc(userId).update({
          'rating': averageRating,
          'reviewCount': ratingsSnapshot.docs.length,
        });
      }
    }
  }

  Stream<List<Rating>> getUserRatings(String userId, String userRole) {
    return _firestore
        .collection('ratings')
        .where('ratedUserId', isEqualTo: userId)
        .where('ratedUserRole', isEqualTo: userRole)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Rating.fromDocument(doc))
        .toList());
  }

  Stream<List<Rating>> getReservationRatings(String reservationId) {
    return _firestore
        .collection('ratings')
        .where('reservationId', isEqualTo: reservationId)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Rating.fromDocument(doc))
        .toList());
  }
}