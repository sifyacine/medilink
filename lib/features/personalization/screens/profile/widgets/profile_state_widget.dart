import 'package:flutter/material.dart';

/// Profile Stat Widget
class ProfileStat extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const ProfileStat({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.white, size: 32), // Icon with size 24
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.white70), // Label text
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
