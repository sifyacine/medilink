import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:get/get.dart';
import 'package:medilink/features/main_pages/controllers/announcement_controller.dart';

import '../../../../../utils/constants/colors.dart';

class MiniMapSelector extends StatefulWidget {
  const MiniMapSelector({super.key});

  @override
  State<MiniMapSelector> createState() => _MiniMapSelectorState();
}

class _MiniMapSelectorState extends State<MiniMapSelector> {
  final MapController _mapController = MapController();
  final Location _location = Location();

  LatLng? _currentLocation;
  LatLng? _selectedPoint;

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  Future<void> _initializeLocation() async {
    try {
      final permission = await _location.requestPermission();
      if (permission != PermissionStatus.granted) return;

      final userLocation = await _location.getLocation();
      setState(() {
        _currentLocation =
            LatLng(userLocation.latitude!, userLocation.longitude!);
      });
    } catch (e) {
      print("Location error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AnnouncementController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select your starting location',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: TColors.primary.withOpacity(0.3)),
          ),
          clipBehavior: Clip.hardEdge,
          child: _currentLocation == null
              ? const Center(child: CircularProgressIndicator())
              : FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _currentLocation!,
              initialZoom: 13.5,
              onTap: (tapPosition, point) {
                setState(() => _selectedPoint = point);


                  controller.startingPointController.text =
                      point.latitude.toStringAsFixed(6);

                  controller.endingPointController.text =
                      point.longitude.toStringAsFixed(6);

              },
            ),
            children: [
              TileLayer(
                urlTemplate:
                "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: const ['a', 'b', 'c'],
              ),
              if (_selectedPoint != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _selectedPoint!,
                      width: 40,
                      height: 40,
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 36,
                      ),
                    ),
                  ],
                ),
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
            ],
          ),
        ),
      ],
    );
  }
}
