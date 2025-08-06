

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:medilink/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:medilink/utils/exceptions/firebase_exceptions.dart';
import 'package:medilink/utils/exceptions/platform_exceptions.dart';

import '../../features/main_pages/models/category_model.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();


  /// variables
  final _db = FirebaseFirestore.instance;

  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection('Categories').get();
      final list = snapshot.docs.map((document) => CategoryModel.fromSnapshot(document)).toList();
      return list;

    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'something went wrong, please try again';
    }

  }


}