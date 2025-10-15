/// Represents an active visit shown on the home screen.
class ActiveVisitModel {
  final String id;
  final String patientName;
  final String address;
  final String imageUrl;

  ActiveVisitModel({
    required this.id,
    required this.patientName,
    required this.address,
    required this.imageUrl,
  });

  /// Factory constructor for creating a new ActiveVisitModel instance from a map.
  factory ActiveVisitModel.fromMap(Map<String, dynamic> map) {
    return ActiveVisitModel(
      id: map['id'] ?? '',
      patientName: map['patientName'] ?? '',
      address: map['address'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );
  }

  /// Static method to create an empty user model.
  static ActiveVisitModel empty() => ActiveVisitModel(id: '', patientName: '', address: '', imageUrl: '');
}


/// Enum to represent different types of activities.
enum ActivityType { reschedule, emergency, newRequest }

/// Represents a single recent activity item.
class RecentActivityModel {
  final String id;
  final String description;
  final ActivityType type;
  final DateTime timestamp;

  RecentActivityModel({
    required this.id,
    required this.description,
    required this.type,
    required this.timestamp,
  });

  void operator [](String other) {}
}