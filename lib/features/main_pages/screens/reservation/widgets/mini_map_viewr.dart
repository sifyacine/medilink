import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/colors.dart';

class MiniMapViewer extends StatefulWidget {
  const MiniMapViewer({
    super.key,
    required this.startingPoint,
    required this.endingPoint,
  });

  final String? startingPoint;
  final String? endingPoint;

  @override
  State<MiniMapViewer> createState() => _MiniMapViewerState();
}

class _MiniMapViewerState extends State<MiniMapViewer> {
  final MapController _mapController = MapController();
  final Location _location = Location();

  LatLng? _currentLocation;
  LatLng? _parsedStartingPoint;
  LatLng? _parsedEndingPoint;

  @override
  void initState() {
    super.initState();
    _initializeLocation();
    _parsePoints();
  }

  void _parsePoints() {
    // Parse starting point if available
    if (widget.startingPoint != null && widget.startingPoint!.isNotEmpty) {
      try {
        final coords = widget.startingPoint!.split(',');
        if (coords.length == 2) {
          final lat = double.tryParse(coords[0].trim());
          final lng = double.tryParse(coords[1].trim());
          if (lat != null && lng != null) {
            _parsedStartingPoint = LatLng(lat, lng);
          }
        }
      } catch (e) {
        print("Error parsing starting point: $e");
      }
    }

    // Parse ending point if available
    if (widget.endingPoint != null && widget.endingPoint!.isNotEmpty) {
      try {
        final coords = widget.endingPoint!.split(',');
        if (coords.length == 2) {
          final lat = double.tryParse(coords[0].trim());
          final lng = double.tryParse(coords[1].trim());
          if (lat != null && lng != null) {
            _parsedEndingPoint = LatLng(lat, lng);
          }
        }
      } catch (e) {
        print("Error parsing ending point: $e");
      }
    }
  }

  Future<void> _initializeLocation() async {
    try {
      final permission = await _location.requestPermission();
      if (permission != PermissionStatus.granted) return;

      final userLocation = await _location.getLocation();
      setState(() {
        _currentLocation = LatLng(userLocation.latitude!, userLocation.longitude!);
      });
    } catch (e) {
      print("Location error: $e");
    }
  }

  LatLng _getInitialCenter() {
    // Prefer showing the starting point, then ending point, then current location
    return _parsedStartingPoint ?? _parsedEndingPoint ?? _currentLocation ?? LatLng(0, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: TColors.primary.withOpacity(0.3)),
      ),
      clipBehavior: Clip.hardEdge,
      child: _currentLocation == null && _parsedStartingPoint == null && _parsedEndingPoint == null
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: _getInitialCenter(),
          initialZoom: 13.5,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: const ['a', 'b', 'c'],
            userAgentPackageName: 'com.medilink.app',
          ),

          // Starting Point Marker
          if (_parsedStartingPoint != null)
            MarkerLayer(
              markers: [
                Marker(
                  point: _parsedStartingPoint!,
                  width: 40,
                  height: 40,
                  child: const Icon(
                    Icons.location_pin,
                    color: Colors.green,
                    size: 36,
                  ),
                ),
              ],
            ),

          // Ending Point Marker
          if (_parsedEndingPoint != null)
            MarkerLayer(
              markers: [
                Marker(
                  point: _parsedEndingPoint!,
                  width: 40,
                  height: 40,
                  child: const Icon(
                    Icons.location_pin,
                    color: Colors.red,
                    size: 36,
                  ),
                ),
              ],
            ),

          // Current Location Marker (only if we have points to show)
          if (_currentLocation != null && (_parsedStartingPoint == null && _parsedEndingPoint == null))
            MarkerLayer(
              markers: [
                Marker(
                  point: _currentLocation!,
                  width: 35,
                  height: 35,
                  child: const Icon(
                    Icons.my_location,
                    color: Colors.blue,
                    size: 28,
                  ),
                ),
              ],
            ),

          // Polyline between points if both exist
          if (_parsedStartingPoint != null && _parsedEndingPoint != null)
            PolylineLayer(
              polylines: [
                Polyline(
                  points: [_parsedStartingPoint!, _parsedEndingPoint!],
                  color: TColors.primary.withOpacity(0.6),
                  strokeWidth: 4,
                ),
              ],
            ),
        ],
      ),
    );
  }
}