import 'package:dio/dio.dart';
import 'package:latlong2/latlong.dart';

class OpenRouteServiceHelper {
  final Dio _dio = Dio();
  final String apiKey = '5b3ce3597851110001cf62484fa5410fe6394939bc03979715edb412';

  /// Fetches a route between two points using OpenRouteService API
  Future<List<LatLng>> getRoute(LatLng start, LatLng end) async {
    const String url = 'https://api.openrouteservice.org/v2/directions/driving-car';

    try {
      // Send request to the OpenRouteService API
      final response = await _dio.post(
        url,
        data: {
          "coordinates": [
            [start.longitude, start.latitude],
            [end.longitude, end.latitude],
          ]
        },
        options: Options(
          headers: {
            'Authorization': apiKey,
            'Content-Type': 'application/json',
          },
        ),
      );

      // Parse and return the route if the response is successful
      if (response.statusCode == 200) {
        final List coordinates = response.data['features'][0]['geometry']['coordinates'];
        return coordinates.map((coord) => LatLng(coord[1], coord[0])).toList();
      } else {
        throw Exception('Failed to get route: ${response.statusMessage}');
      }
    } on DioException {
      // Handle Dio-specific errors
      rethrow;
    } catch (e) {
      // Handle general errors
      rethrow;
    }
  }
}