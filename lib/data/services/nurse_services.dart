import 'package:cloud_firestore/cloud_firestore.dart';

import '../../features/authentication/models/nurse_model.dart';


class NurseService {
  // Wrap the collection with a converter for type safety.
  final CollectionReference<NurseModel> usersCollection =
  FirebaseFirestore.instance.collection('Users').withConverter<NurseModel>(
    fromFirestore: (snapshot, _) => NurseModel.fromSnapshot(snapshot),
    toFirestore: (nurse, _) => nurse.toJson(),
  );

  // Base query for nurses (filtered by role)
  Query<NurseModel> _baseNurseQuery({DocumentSnapshot? lastDoc, int? limit}) {
    Query<NurseModel> query = usersCollection.where('role', isEqualTo: 'nurse');
    if (limit != null) {
      query = query.limit(limit);
    }
    if (lastDoc != null) {
      query = query.startAfterDocument(lastDoc);
    }
    return query;
  }

  /// Get document snapshot for pagination
  Future<DocumentSnapshot?> getDocumentSnapshot(String id) async {
    try {
      return await usersCollection.doc(id).get();
    } catch (e) {
      print('Error getting document snapshot: $e');
      return null;
    }
  }

  /// Create a new nurse in Firestore.
  Future<void> createNurse(NurseModel nurse) async {
    try {
      final docRef = usersCollection.doc();
      nurse.createdAt = DateTime.now().toUtc();
      nurse.updatedAt = DateTime.now().toUtc();
      print('Creating nurse with ID: ${docRef.id}');
      await docRef.set(nurse);
      print('Nurse created successfully');
    } catch (e) {
      print('Error creating nurse: $e');
      rethrow;
    }
  }

  /// Retrieve a single nurse by its id.
  Future<NurseModel?> getNurseById(String id) async {
    try {
      final docSnap = await usersCollection.doc(id).get();
      final data = docSnap.data();
      if (data == null || data.role != 'nurse') {
        return null; // Not a nurse
      }
      return data;
    } catch (e) {
      print('Error getting nurse: $e');
      return null;
    }
  }

  /// Retrieve all nurses with pagination.
  Future<List<NurseModel>> getAllNurses({int? limit, DocumentSnapshot? lastDoc}) async {
    try {
      final query = _baseNurseQuery(lastDoc: lastDoc, limit: limit);
      final snapshot = await query.get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print('Error retrieving nurses: $e');
      return [];
    }
  }

  /// Update an existing nurse.
  Future<void> updateNurse(NurseModel nurse) async {
    try {
      nurse.updatedAt = DateTime.now().toUtc();
      await usersCollection.doc(nurse.id).update(nurse.toJson());
    } catch (e) {
      print('Error updating nurse: $e');
      rethrow;
    }
  }

  /// Delete a nurse by its id.
  Future<void> deleteNurse(String id) async {
    try {
      await usersCollection.doc(id).delete();
    } catch (e) {
      print('Error deleting nurse: $e');
      rethrow;
    }
  }

  /// Search nurses with optional filters.
  Future<List<NurseModel>> searchNurses({
    String? keyword,
    String? city,
    String? state,
    String? specialization,
    double? minRating,
    int? minReviewCount,
    DateTime? minDateOfBirth,
    int limit = 1000,
    DocumentSnapshot? lastDoc,
  }) async {
    try {
      Query<NurseModel> query = _baseNurseQuery(lastDoc: lastDoc, limit: limit);

      if (keyword != null && keyword.isNotEmpty) {
        // Search in fullName or bio; using arrayContains on bio if list, but since string, use where with inequality or client-side
        // For simplicity, assume keyword search on bio or name client-side, or adjust model; here using where on bio isEqualTo for exact, but for contains, need index or client
        // To mirror, use where('bio', isEqualTo: keyword); // exact match
        print('Note: For keyword search on string fields like bio, consider full-text search or client-side filtering.');
        // Placeholder: query = query.where('bio', isEqualTo: keyword); // exact match
      }
      if (city != null && city.isNotEmpty) {
        query = query.where('city', isEqualTo: city);
      }
      if (state != null && state.isNotEmpty) {
        query = query.where('state', isEqualTo: state);
      }
      if (specialization != null && specialization.isNotEmpty) {
        query = query.where('specialization', isEqualTo: specialization);
      }
      if (minRating != null && minRating > 0) {
        query = query.where('rating', isGreaterThanOrEqualTo: minRating);
      }
      if (minReviewCount != null && minReviewCount > 0) {
        query = query.where('reviewCount', isGreaterThanOrEqualTo: minReviewCount);
      }
      if (minDateOfBirth != null) {
        query = query.where('dateOfBirth', isLessThanOrEqualTo: Timestamp.fromDate(minDateOfBirth));
      }

      final snapshot = await query.get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print('Error searching nurses: $e');
      if (e.toString().contains('requires an index')) {
        print('Index required. Please create the index in Firebase Console: ${e.toString()}');
        throw Exception('Missing Firestore index. Please contact support or check logs.');
      }
      throw Exception('Failed to search nurses: $e');
    }
  }

  /// Retrieve active and verified nurses sorted by a specified field with retry logic.
  Future<List<NurseModel>> getActiveNurses({
    String orderBy = 'createdAt',
    bool descending = true,
    int limit = 1000,
    DocumentSnapshot? lastDoc,
  }) async {
    const maxRetries = 3;
    int attempt = 0;

    while (attempt < maxRetries) {
      try {
        Query<NurseModel> query = _baseNurseQuery(lastDoc: lastDoc, limit: limit)
            .where('isActive', isEqualTo: true)
            .where('isVerified', isEqualTo: true)
            .orderBy(orderBy, descending: descending);

        final snapshot = await query.get();
        return snapshot.docs.map((doc) => doc.data()).toList();
      } catch (e) {
        attempt++;
        print('Error getting active nurses (attempt $attempt/$maxRetries): $e');
        if (e.toString().contains('requires an index')) {
          print('Index required. Please create the index in Firebase Console: ${e.toString()}');
          throw Exception('Missing Firestore index. Please contact support or check logs.');
        }
        if (attempt == maxRetries) {
          print('Failed after $maxRetries attempts');
          throw Exception('Failed to fetch active nurses: $e');
        }
        await Future.delayed(Duration(seconds: attempt));
      }
    }
    return [];
  }

  /// Retrieve nurses sorted by a specified field with pagination.
  Future<List<NurseModel>> sortNurses({
    String orderBy = 'createdAt',
    bool descending = true,
    int? limit,
    DocumentSnapshot? lastDoc,
  }) async {
    try {
      Query<NurseModel> query = _baseNurseQuery(lastDoc: lastDoc, limit: limit)
          .orderBy(orderBy, descending: descending);

      final snapshot = await query.get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print('Error sorting nurses: $e');
      if (e.toString().contains('requires an index')) {
        print('Index required. Please create the index in Firebase Console: ${e.toString()}');
        throw Exception('Missing Firestore index. Please contact support or check logs.');
      }
      throw Exception('Failed to sort nurses: $e');
    }
  }

  /// Retrieve nurses by workplace with retry logic and pagination.
  Future<List<NurseModel>> getNursesByWorkplace(
      String workplace, {
        int limit = 20,
        DocumentSnapshot? lastDoc,
      }) async {
    const maxRetries = 3;
    int attempt = 0;

    while (attempt < maxRetries) {
      try {
        print('🔍 Service: Fetching nurses for workplace: $workplace');
        Query<NurseModel> query = _baseNurseQuery(lastDoc: lastDoc, limit: limit)
            .where('workplace', isEqualTo: workplace)
            .orderBy('createdAt', descending: true);

        final snapshot = await query.get();
        print('✅ Service: Found ${snapshot.docs.length} nurses');
        for (var doc in snapshot.docs) {
          final data = doc.data();
          print('📄 Nurse: ${data.id} - ${data.fullName} - Specialization: ${data.specialization}');
        }

        return snapshot.docs.map((doc) => doc.data()).toList();
      } catch (e) {
        attempt++;
        print('❌ Service Error getting workplace nurses (attempt $attempt/$maxRetries): $e');
        if (e.toString().contains('requires an index')) {
          print('Index required. Please create the index in Firebase Console: ${e.toString()}');
          throw Exception('Missing Firestore index. Please contact support or check logs.');
        }
        if (attempt == maxRetries) {
          print('Failed after $maxRetries attempts');
          throw Exception('Failed to fetch nurses: $e');
        }
        await Future.delayed(Duration(seconds: attempt));
      }
    }
    return [];
  }

  /// Update nurse verification status.
  Future<void> updateNurseVerification(String id, bool isVerified) async {
    try {
      await usersCollection.doc(id).update({
        'isVerified': isVerified,
        'updatedAt': Timestamp.fromDate(DateTime.now().toUtc()),
      });
    } catch (e) {
      print('Error updating nurse verification: $e');
      rethrow;
    }
  }

  /// Increment review count for a nurse.
  Future<void> incrementReviewCount(String id) async {
    try {
      await usersCollection.doc(id).update({
        'reviewCount': FieldValue.increment(1),
        'updatedAt': Timestamp.fromDate(DateTime.now().toUtc()),
      });
    } catch (e) {
      print('Error incrementing review count: $e');
      rethrow;
    }
  }
}