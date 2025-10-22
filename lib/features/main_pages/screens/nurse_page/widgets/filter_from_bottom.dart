import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/nurse_controller.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NurseController>();
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          const ListTile(
            title: Text(
              "Filter by Specialization",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            leading: Icon(Icons.filter_list),
          ),
          const Divider(),
          // Filter options with consistent styling
          ...[
            {"title": "All", "icon": Icons.all_inclusive, "filter": "All"},
            {"title": "ICU", "icon": Icons.local_hospital, "filter": "ICU"},
            {"title": "Pediatrics", "icon": Icons.child_care, "filter": "Pediatrics"},
            // Add more as needed
            // {"title": "Cardiology", "icon": Icons.favorite, "filter": "Cardiology"},
          ].map((filterOption) => ListTile(
            title: Text(filterOption["title"] as String),
            leading: Icon(filterOption["icon"] as IconData),
            onTap: () {
              controller.updateFilter(filterOption["filter"] as String);
              Navigator.pop(context);
            },
          )),
          const SizedBox(height: 16),
          // Clear Filter Button
          TextButton(
            onPressed: () {
              controller.updateFilter("All");
              Navigator.pop(context);
            },
            child: const Text("Clear Filters"),
          ),
        ],
      ),
    );
  }
}