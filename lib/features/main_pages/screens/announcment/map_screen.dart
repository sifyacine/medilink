import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:medilink/features/main_pages/screens/announcment/widgets/maps_hellper.dart';


class RouteMapScreen extends StatefulWidget {
  @override
  _RouteMapScreenState createState() => _RouteMapScreenState();
}

class _RouteMapScreenState extends State<RouteMapScreen> {
  final MapController _mapController = MapController();
  LatLng? _currentLocation;
  List<LatLng> _routePoints = [];
  final LatLng _end = const LatLng(36.752887, 3.042048); // Example destination
  final Location _location = Location();

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  Future<void> _initializeLocation() async {
    try {
      // Request location permissions
      final hasPermission = await _location.requestPermission();
      if (hasPermission != PermissionStatus.granted) {
        throw Exception("Location permission not granted");
      }

      // Get the user's current location
      final userLocation = await _location.getLocation();
      setState(() {
        _currentLocation = LatLng(userLocation.latitude!, userLocation.longitude!);
      });

      // Optionally, fetch the route
      _fetchRoute();
    } catch (e) {
      print("Error initializing location: $e");
    }
  }

  Future<void> _fetchRoute() async {
    if (_currentLocation == null) return;

    final helper = OpenRouteServiceHelper();
    try {
      final route = await helper.getRoute(_currentLocation!, _end);
      setState(() {
        _routePoints = route;
      });
    } catch (e) {
      print('Error fetching route: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentLocation == null
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          crs: const Epsg3857(),
          initialCenter: _currentLocation!,
          initialZoom: 15.0,
          minZoom: 5.0,
          maxZoom: 18.0,
          backgroundColor: const Color(0xFFE0E0E0),
          onTap: (tapPosition, latlng) {
          },
          onMapReady: () {
          },
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: const ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: _currentLocation!,
                width: 40,
                height: 40,
                child: const Icon(Icons.my_location, color: Colors.blue, size: 30),
              ),
              Marker(
                point: _end,
                width: 40,
                height: 40,
                child: const Icon(Icons.location_on, color: Colors.red, size: 30),
              ),
            ],
          ),
          if (_routePoints.isNotEmpty)
            PolylineLayer(
              polylines: [
                Polyline(
                  points: _routePoints,
                  strokeWidth: 4.0,
                  color: Colors.blue,
                ),
              ],
            ),
        ],
      ),
    );
  }
}