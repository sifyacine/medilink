import 'package:flutter/material.dart';

/// Profile Stat Widget
class ProfileStat extends StatelessWidget {
  final Widget icon; // Changed from IconData to Widget
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
        SizedBox(
          height: 32,
          width: 32,
          child: icon, // Now uses the passed widget
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.black),
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
