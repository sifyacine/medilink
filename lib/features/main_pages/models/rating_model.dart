import 'package:cloud_firestore/cloud_firestore.dart';

class Rating {
  String id;
  String reservationId;
  String ratedUserId;
  String raterUserId;

  int rating;
  String comment;
  DateTime createdAt;

  String ratedUserRole;
  String raterUserRole;

  Rating({
    required this.id,
    required this.reservationId,
    required this.ratedUserId,
    required this.raterUserId,
    required this.rating,
    required this.comment,
    required this.ratedUserRole,
    required this.raterUserRole,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reservationId': reservationId,
      'ratedUserId': ratedUserId,
      'raterUserId': raterUserId,
      'rating': rating,
      'comment': comment,
      'ratedUserRole': ratedUserRole,
      'raterUserRole': raterUserRole,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  factory Rating.fromDocument(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return Rating(
      id: data['id'] ?? document.id,
      reservationId: data['reservationId'] ?? '',
      ratedUserId: data['ratedUserId'] ?? '',
      raterUserId: data['raterUserId'] ?? '',
      rating: data['rating'] ?? 0,
      comment: data['comment'] ?? '',
      ratedUserRole: data['ratedUserRole'] ?? '',
      raterUserRole: data['raterUserRole'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  // Empty rating
  static Rating empty() => Rating(
    id: '',
    reservationId: '',
    ratedUserId: '',
    raterUserId: '',
    rating: 0,
    comment: '',
    ratedUserRole: '',
    raterUserRole: '',
  );
}