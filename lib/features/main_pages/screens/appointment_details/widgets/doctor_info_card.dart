import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink/utils/constants/image_strings.dart';

import '../../../controllers/appointment_controller.dart';

class DoctorInfoCard extends StatelessWidget {
  final AppointmentController controller;

  const DoctorInfoCard({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Doctor photo (replace with actual image)
            const CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(TImages.user1),
            ),
            const SizedBox(width: 16),
            // Doctor details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() {
                    return Text(
                      controller.doctorName.value,
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    );
                  }),
                  Obx(() {
                    return Text(
                      controller.specialization.value,
                      style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey[700]),
                    );
                  }),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Obx(() {
                        return Text(
                          '${controller.rating.value}',
                          style: theme.textTheme.bodyMedium,
                        );
                      }),
                      const SizedBox(width: 4),
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 16),
                      Obx(() {
                        return Text(
                          controller.distance.value,
                          style: theme.textTheme.bodyMedium,
                        );
                      }),
                      const SizedBox(width: 4),
                      const Icon(Icons.location_on, color: Colors.red, size: 16),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
