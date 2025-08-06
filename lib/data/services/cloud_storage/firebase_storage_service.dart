
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../features/main_pages/models/category_model.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';


class TFirebaseStorageService extends GetxController {
  static TFirebaseStorageService get instance => Get.find();

  final firebaseStorage = FirebaseStorage.instance;
  final _db = FirebaseFirestore.instance;



  // Upload Local Assets from IDE
  // Returns a Uint8List containing image data
  Future<Uint8List> getImageDataFromAssets(String path) async {
    try {
      final byteData = await rootBundle.load(path);
      final imageData = byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
      return imageData;
    } catch (e) {
      // Handle exceptions gracefully
      throw 'Error loading image data: $e';
    }
  }

  Future<String> uploadImageData(String path, Uint8List image, String name) async {
    try {
      final ref = firebaseStorage.ref(path).child(name);
      await ref.putData(image);
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      // Handle exceptions gracefully
      if (e is FirebaseException) {
        throw 'Firebase Error: ${e.message}';
      } else if (e is SocketException) {
        throw 'Network Error: ${e.message}';
      } else if (e is PlatformException) {
        throw 'Platform Exception: ${e.message}';
      } else {
        throw 'Something Went Wrong! Please try again.';
      }
    }
  }

  Future<String> uploadImageFile(String path, XFile image) async {
    try {
      final ref = firebaseStorage.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      // Handle exceptions gracefully
      if (e is FirebaseException) {
        throw 'Firebase Error: ${e.message}';
      } else if (e is SocketException) {
        throw 'Network Error: ${e.message}';
      } else if (e is PlatformException) {
        throw 'Platform Exception: ${e.message}';
      } else {
        throw 'Something Went Wrong! Please try again.';
      }
    }
  }

  /// Upload Categories to the Cloud Firebase
  Future<void> uploadDummyData(List<CategoryModel> categories) async {
    try {
      // Upload all the Categories along with their Images
      final storage = Get.put(TFirebaseStorageService());

      // Loop through each category
      for (var category in categories) {
        // Get ImageData link from the local assets
        final file = await storage.getImageDataFromAssets(category.image);

        // Upload Image and Get its URL
        final url = await storage.uploadImageData('Categories', file, category.name);

        // Assign URL to Category.image attribute
        category.image = url;

        // Store Category in Firestore
        await _db.collection("categories").doc(category.id).set(category.toJson());
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

}

