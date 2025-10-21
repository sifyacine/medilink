import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/nurse_controller.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NurseController>(); // Use find to get existing instance
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
          ListTile(
            title: const Text("All"),
            leading: const Icon(Icons.all_inclusive),
            onTap: () {
              controller.updateFilter("All");
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text("ICU"),
            leading: const Icon(Icons.local_hospital),
            onTap: () {
              controller.updateFilter("ICU");
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text("Pediatrics"),
            leading: const Icon(Icons.child_care),
            onTap: () {
              controller.updateFilter("Pediatrics");
              Navigator.pop(context);
            },
          ),
          // Add more filter options as needed, e.g.:
          // ListTile(
          //   title: const Text("Cardiology"),
          //   leading: const Icon(Icons.favorite),
          //   onTap: () {
          //     controller.updateFilter("Cardiology");
          //     Navigator.pop(context);
          //   },
          // ),
          const SizedBox(height: 16),
          // Clear Filter Button (optional)
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