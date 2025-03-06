import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:midilink/features/personalization/screens/profile/widgets/profile_header.dart';
import 'package:midilink/features/personalization/screens/profile/widgets/profile_menu_tile.dart';
import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          /// Profile Header
          const TPrimaryHeaderContainer(
            child: ProfileHeader(),
          ),

          /// Menu Items
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0),
              child: ListView(
                children: const [
                  ProfileMenuTile(
                      icon: Iconsax.heart, title: "My Saved Items"),
                  ProfileMenuTile(
                      icon: Iconsax.document, title: "My Documents"),
                  ProfileMenuTile(
                      icon: Iconsax.calendar, title: "Appointments"),
                  ProfileMenuTile(
                      icon: Iconsax.setting, title: "App Settings"),
                  ProfileMenuTile(
                      icon: Iconsax.message_question, title: "FAQs"),
                  ProfileMenuTile(
                      icon: Iconsax.logout, title: "Logout", isLogout: true),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

