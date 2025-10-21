
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' hide Settings;
import 'package:medilink/firebase_options.dart';

import 'app.dart';
import 'data/repositories/authentication_repository.dart';
import 'data/user/user_repository.dart';


Future<void> main() async {
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  /// Load environment variables
  await dotenv.load(fileName: ".env");


  await GetStorage.init();

  /// Debug print

  /// Retrieve the access token
  String? accessToken = dotenv.env['MAP_API_KEY'];


  MapboxOptions.setAccessToken(accessToken!);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((FirebaseApp value) {
    // Initialize both AuthenticationRepository and UserRepository
    Get.put(AuthenticationRepository());
    Get.put(UserRepository()); // Add this line
  });


  runApp(App());
}

