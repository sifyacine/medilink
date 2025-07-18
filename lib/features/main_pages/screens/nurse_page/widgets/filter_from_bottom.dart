import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/nurse_controller.dart';


class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NurseController());
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text("All"),
            onTap: () {
              controller.updateFilter("All");
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text("ICU"),
            onTap: () {
              controller.updateFilter("ICU");
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text("Pediatrics"),
            onTap: () {
              controller.updateFilter("Pediatrics");
              Navigator.pop(context);
            },
          ),
          // Add more filter options as needed.
        ],
      ),
    );
  }
}
