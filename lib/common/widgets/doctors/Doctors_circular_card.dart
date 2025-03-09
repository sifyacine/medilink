import 'package:flutter/material.dart';

class DoctorsCircularCard extends StatelessWidget {
  final String imagePath;
  final String doctorName;

  const DoctorsCircularCard({
    Key? key,
    required this.imagePath,
    required this.doctorName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40, // Adjust the size as needed
          backgroundImage: AssetImage(imagePath), // For local assets. Use NetworkImage if needed.
        ),
        const SizedBox(height: 8),
        Text(
          doctorName,
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ],
    );
  }
}
