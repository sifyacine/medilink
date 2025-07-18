import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:medilink/common/widgets/appbar/appbar.dart';
import 'package:medilink/utils/constants/colors.dart';

import '../../controllers/map_controller.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: TextField(
        decoration: const InputDecoration(
          hintText: 'Rechercher un lieu, un code postal...',
          prefixIcon: Icon(Icons.search),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        onSubmitted: (query) {
          debugPrint("Search query: $query");
        },
      ),
    );
  }
}

class EmergenciesMapPage extends StatelessWidget {
  const EmergenciesMapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Instantiate the MapController using Get.put.
    final controller = Get.put(MapController());

    return Scaffold(
      appBar: TAppBar(
        title: Text("Emergencies"),
        centerTitle: true,
        showBackArrow: true,
      ),
      
      body: Stack(
        children: [
          // 1. Map widget using controller's onMapCreated callback.
          MapWidget(
            key: const ValueKey("mapWidget"),
            onMapCreated: controller.onMapCreated,
          ),
      
          // 2. Top search bar.
          const Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: SearchBar(),
          ),
      
          // 3. Circular accuracy ring for visual effect.
          Positioned.fill(
            child: IgnorePointer(
              child: Center(
                child: Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: TColors.primary,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
          ),
      
          // 4. Marker pin icon at the center.
          const Positioned.fill(
            child: IgnorePointer(
              child: Center(
                child: Icon(
                  Icons.location_on,
                  size: 36,
                  color: TColors.primary,
                ),
              ),
            ),
          ),
      
          // 5. Bottom card to confirm location.
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Confirm your address',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '2640 Cabin Creek Rd #102 Alexandria, Virginia(VA), 22314',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          debugPrint('Location Confirmed');
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Confirm Location'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
