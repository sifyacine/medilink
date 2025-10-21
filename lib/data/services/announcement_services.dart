import 'package:cloud_firestore/cloud_firestore.dart';

import '../../features/main_pages/models/announcment_model.dart';

class AnnouncementService {
  // Wrap the collection with a converter for type safety.
  final CollectionReference<Announcement> announcementsCollection =
  FirebaseFirestore.instance.collection('announcements').withConverter<Announcement>(
    fromFirestore: (snapshot, _) => Announcement.fromDocument(snapshot),
    toFirestore: (announcement, _) => announcement.toMap(),
  );

  /// Get document snapshot for pagination
  Future<DocumentSnapshot?> getDocumentSnapshot(String uid) async {
    try {
      return await announcementsCollection.doc(uid).get();
    } catch (e) {
      print('Error getting document snapshot: $e');
      return null;
    }
  }

  /// Create a new announcement in Firestore.
  Future<void> createAnnouncement(Announcement announcement) async {
    try {
      final docRef = announcementsCollection.doc();
      announcement.uid = docRef.id;
      announcement.createdAt = DateTime.now().toUtc();
      announcement.updatedAt = DateTime.now().toUtc();
      print('Creating announcement with ID: ${docRef.id}');
      await docRef.set(announcement);
      print('Announcement created successfully');
    } catch (e) {
      print('Error creating announcement: $e');
      rethrow;
    }
  }

  /// Retrieve a single announcement by its uid.
  Future<Announcement?> getAnnouncementById(String uid) async {
    try {
      final docSnap = await announcementsCollection.doc(uid).get();
      return docSnap.data();
    } catch (e) {
      print('Error getting announcement: $e');
      return null;
    }
  }

  /// Retrieve all announcements with pagination.
  Future<List<Announcement>> getAllAnnouncements({int limit = 20, DocumentSnapshot? lastDoc}) async {
    try {
      Query<Announcement> query = announcementsCollection.limit(limit);
      if (lastDoc != null) {
        query = query.startAfterDocument(lastDoc);
      }
      final snapshot = await query.get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print('Error retrieving announcements: $e');
      return [];
    }
  }

  /// Update an existing announcement.
  Future<void> updateAnnouncement(Announcement announcement) async {
    try {
      announcement.updatedAt = DateTime.now().toUtc();
      await announcementsCollection.doc(announcement.uid).update(announcement.toMap());
    } catch (e) {
      print('Error updating announcement: $e');
      rethrow;
    }
  }

  /// Delete an announcement by its uid.
  Future<void> deleteAnnouncement(String uid) async {
    try {
      await announcementsCollection.doc(uid).delete();
    } catch (e) {
      print('Error deleting announcement: $e');
      rethrow;
    }
  }

  /// Search announcements with optional filters.
  Future<List<Announcement>> searchAnnouncements({
    String? keyword,
    String? city,
    String? state,
    String? targetAudience,
    int? minAge,
    int? maxAge,
    DateTime? startDate,
    int limit = 20,
    DocumentSnapshot? lastDoc,
  }) async {
    try {
      Query<Announcement> query = announcementsCollection.limit(limit);
      if (lastDoc != null) {
        query = query.startAfterDocument(lastDoc);
      }

      if (keyword != null && keyword.isNotEmpty) {
        query = query.where('additionalNotes', arrayContains: keyword);
      }
      if (city != null && city.isNotEmpty) {
        query = query.where('city', isEqualTo: city);
      }
      if (state != null && state.isNotEmpty) {
        query = query.where('state', isEqualTo: state);
      }
      if (targetAudience != null && targetAudience.isNotEmpty) {
        query = query.where('targetAudience', isEqualTo: targetAudience);
      }
      if (minAge != null && minAge > 0) {
        query = query.where('minAge', isLessThanOrEqualTo: minAge);
      }
      if (maxAge != null && maxAge < 100) {
        query = query.where('maxAge', isGreaterThanOrEqualTo: maxAge);
      }
      if (startDate != null) {
        query = query.where('startDate', isGreaterThanOrEqualTo: Timestamp.fromDate(startDate));
      }

      final snapshot = await query.get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print('Error searching announcements: $e');
      if (e.toString().contains('requires an index')) {
        print('Index required. Please create the index in Firebase Console: ${e.toString()}');
        throw Exception('Missing Firestore index. Please contact support or check logs.');
      }
      throw Exception('Failed to search announcements: $e');
    }
  }

  /// Retrieve active guarding service announcements sorted by a specified field with retry logic.
  Future<List<Announcement>> getActiveAnnouncements({
    String orderBy = 'createdAt',
    bool descending = true,
    int limit = 20,
    DocumentSnapshot? lastDoc,
  }) async {
    const maxRetries = 3;
    int attempt = 0;

    while (attempt < maxRetries) {
      try {
        Query<Announcement> query = announcementsCollection
            .where('isActive', isEqualTo: true)
            .where('status', whereIn: ['Pending', 'Approved', 'Active'])
            .orderBy(orderBy, descending: descending)
            .limit(limit);

        if (lastDoc != null) {
          query = query.startAfterDocument(lastDoc);
        }

        final snapshot = await query.get();
        return snapshot.docs.map((doc) => doc.data()).toList();
      } catch (e) {
        attempt++;
        print('Error getting active announcements (attempt $attempt/$maxRetries): $e');
        if (e.toString().contains('requires an index')) {
          print('Index required. Please create the index in Firebase Console: ${e.toString()}');
          throw Exception('Missing Firestore index. Please contact support or check logs.');
        }
        if (attempt == maxRetries) {
          print('Failed after $maxRetries attempts');
          throw Exception('Failed to fetch active announcements: $e');
        }
        await Future.delayed(Duration(seconds: attempt));
      }
    }
    return [];
  }

  /// Retrieve announcements sorted by a specified field with pagination.
  Future<List<Announcement>> sortAnnouncements({
    String orderBy = 'createdAt',
    bool descending = true,
    int limit = 20,
    DocumentSnapshot? lastDoc,
  }) async {
    try {
      Query<Announcement> query = announcementsCollection
          .orderBy(orderBy, descending: descending)
          .limit(limit);

      if (lastDoc != null) {
        query = query.startAfterDocument(lastDoc);
      }

      final snapshot = await query.get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print('Error sorting announcements: $e');
      if (e.toString().contains('requires an index')) {
        print('Index required. Please create the index in Firebase Console: ${e.toString()}');
        throw Exception('Missing Firestore index. Please contact support or check logs.');
      }
      throw Exception('Failed to sort announcements: $e');
    }
  }

  /// Retrieve announcements by publisher with retry logic and pagination.
  Future<List<Announcement>> getAnnouncementsByPublisher(
      String publisherId, {
        int limit = 20,
        DocumentSnapshot? lastDoc,
      }) async {
    const maxRetries = 3;
    int attempt = 0;

    while (attempt < maxRetries) {
      try {
        print('🔍 Service: Fetching announcements for publisher: $publisherId');
        Query<Announcement> query = announcementsCollection
            .where('publisherId', isEqualTo: publisherId)
            .orderBy('createdAt', descending: true)
            .limit(limit);

        if (lastDoc != null) {
          query = query.startAfterDocument(lastDoc);
        }

        final snapshot = await query.get();
        print('✅ Service: Found ${snapshot.docs.length} announcements');
        for (var doc in snapshot.docs) {
          final data = doc.data();
          print('📄 Announcement: ${data.uid} - ${data.targetAudience} - Status: ${data.status}');
        }

        return snapshot.docs.map((doc) => doc.data()).toList();
      } catch (e) {
        attempt++;
        print('❌ Service Error getting publisher announcements (attempt $attempt/$maxRetries): $e');
        if (e.toString().contains('requires an index')) {
          print('Index required. Please create the index in Firebase Console: ${e.toString()}');
          throw Exception('Missing Firestore index. Please contact support or check logs.');
        }
        if (attempt == maxRetries) {
          print('Failed after $maxRetries attempts');
          throw Exception('Failed to fetch announcements: $e');
        }
        await Future.delayed(Duration(seconds: attempt));
      }
    }
    return [];
  }

  /// Update announcement status.
  Future<void> updateAnnouncementStatus(String uid, String newStatus) async {
    try {
      await announcementsCollection.doc(uid).update({
        'status': newStatus,
        'updatedAt': Timestamp.fromDate(DateTime.now().toUtc()),
      });
    } catch (e) {
      print('Error updating announcement status: $e');
      rethrow;
    }
  }

  /// Increment views count for an announcement.
  Future<void> incrementViews(String uid) async {
    try {
      await announcementsCollection.doc(uid).update({
        'views': FieldValue.increment(1),
        'updatedAt': Timestamp.fromDate(DateTime.now().toUtc()),
      });
    } catch (e) {
      print('Error incrementing views: $e');
      rethrow;
    }
  }
}