class Review {
  final String id;
  final String uid;
  final double rating;
  final String reviewTargetId;
  final String title;
  final String comment;
  final DateTime createdAt;
  final DateTime updatedAt;

  Review({
    required this.id,
    required this.uid,
    required this.rating,
    required this.reviewTargetId,
    required this.title,
    required this.comment,
    required this.createdAt,
    required this.updatedAt,
  });

  // Create a Review instance from a JSON object.
  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] as String,
      uid: json['uid'] as String,
      rating: (json['rating'] as num).toDouble(),
      reviewTargetId: json['review_target_id'] as String,
      title: json['title'] as String,
      comment: json['comment'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  // Convert a Review instance to a JSON object.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'rating': rating,
      'review_target_id': reviewTargetId,
      'title': title,
      'comment': comment,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
