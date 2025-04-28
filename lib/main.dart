import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

import 'app.dart';


void main() async {

  /// Load environment variables
  await dotenv.load(fileName: ".env");



  /// Debug print

  /// Retrieve the access token
  String? accessToken = dotenv.env['MAP_API_KEY'];


  MapboxOptions.setAccessToken(accessToken!);

  runApp(App());
}
