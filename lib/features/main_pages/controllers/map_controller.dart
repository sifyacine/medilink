import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart' as geo;

class MapController extends GetxController {
  MapboxMap? mapboxMap;
  Rxn<geo.Position> currentPosition = Rxn<geo.Position>();

  @override
  void onInit() {
    super.onInit();
    // Update the camera when a new position is set.
    ever(currentPosition, (_) {
      if (currentPosition.value != null && mapboxMap != null) {
        mapboxMap!.setCamera(CameraOptions(
          center: Point(
            coordinates: Position(
              currentPosition.value!.longitude,
              currentPosition.value!.latitude,
            ),
          ),
          zoom: 15.0,
          bearing: -17.6,
          pitch: 0,
        ));
      }
    });
  }

  // Called when the MapWidget is created.
  Future<void> onMapCreated(MapboxMap map) async {
    mapboxMap = map;
    await _requestPermission();
    // Enable location component.
    mapboxMap?.location.updateSettings(
      LocationComponentSettings(enabled: false),
    );

    try {
      final position = await _determinePosition();
      currentPosition.value = position;
    } catch (e) {
      debugPrint("Error determining position: $e");
    }
  }

  // Determine the current position using geolocator.
  Future<geo.Position> _determinePosition() async {
    bool serviceEnabled = await geo.Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    geo.LocationPermission permission = await geo.Geolocator.checkPermission();
    if (permission == geo.LocationPermission.denied) {
      permission = await geo.Geolocator.requestPermission();
      if (permission == geo.LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }
    if (permission == geo.LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    return await geo.Geolocator.getCurrentPosition();
  }

  // Request location permission.
  Future<void> _requestPermission() async {
    var status = await Permission.locationWhenInUse.request();
    debugPrint("Location permission status: $status");
  }
}
