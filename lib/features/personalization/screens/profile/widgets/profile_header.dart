import 'package:flutter/material.dart';
import 'package:midilink/features/personalization/screens/profile/widgets/profile_state_widget.dart';


/// Profile Header Widget
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // Ensures it takes minimal space

      children: [
        const SizedBox(height: 75), // Pushes profile picture down
        const CircleAvatar(
          radius: 48,
          backgroundImage: AssetImage(
              "assets/images/content/user.png"), // Change with your asset
        ),
        const SizedBox(height: 10),
        const Text(
          "Mahdaoui Salma",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const ProfileStat(icon: Icons.favorite, label: "Heart Rate", value: "215 bpm"),

            // Vertical Line Separator
            Container(height: 40, width: 1, color: Colors.white30),

            const ProfileStat(icon: Icons.local_fire_department, label: "Calories", value: "756 cal"),

            // Vertical Line Separator
            Container(height: 40, width: 1, color: Colors.white30),

            const ProfileStat(icon: Icons.monitor_weight, label: "Weight", value: "103 lbs"),
          ],
        ),
      ],
    );
  }
}
