import 'package:flutter/material.dart';
class DoctorsCircularCard extends StatelessWidget {
  const DoctorsCircularCard({
    super.key,
    required this.imagePath,
    required this.doctorName,
    this.onTap,
  });

  final String imagePath;
  final String doctorName;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(imagePath),
          ),
          const SizedBox(height: 4),
          Text(doctorName),
        ],
      ),
    );
  }
}