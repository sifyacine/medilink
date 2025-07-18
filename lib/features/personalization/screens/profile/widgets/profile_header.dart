import 'package:flutter/material.dart';
import 'package:medilink/features/personalization/screens/profile/widgets/profile_state_widget.dart';


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
              "assets/images/content/DAHMANE Djamel Eddine.jpg"), // Change with your asset
        ),
        const SizedBox(height: 10),
        const Text(
          "DAHMANE Djamel Eddine",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ProfileStat(
              icon: Image.asset('assets/icons/categories/prescription.png'),
              label: 'Prescription',
              value: '',
            ),
            Container(height: 40, width: 1, color: Colors.black),

            ProfileStat(
              icon: Image.asset('assets/icons/categories/sos.png'),
              label: 'SOS',
              value: '',
            ),
            Container(height: 40, width: 1, color: Colors.black),

            ProfileStat(
              icon: Image.asset('assets/icons/categories/medical-records.png'),
              label: 'Medical folder',
              value: '',
            ),

          ],
        ),
      ],
    );
  }
}
