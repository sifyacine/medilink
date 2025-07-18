import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Profile Header with circular avatar and name
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                          image: AssetImage("assets/images/content/DAHMANE Djamel Eddine.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: TColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'DAHMANE Djamel Eddine',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Menu Items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: const [
                ProfileMenuItem(
                  icon: Icons.person_outline,
                  title: 'Your profile',
                ),
                ProfileMenuItem(
                  icon: Icons.location_on_outlined,
                  title: 'Manage Address',
                ),
                ProfileMenuItem(
                  icon: Icons.credit_card_outlined,
                  title: 'Payment Methods',
                ),
                ProfileMenuItem(
                  icon: Icons.calendar_today_outlined,
                  title: 'My Bookings',
                ),
                ProfileMenuItem(
                  icon: Icons.account_balance_wallet_outlined,
                  title: 'My Wallet',
                ),
                ProfileMenuItem(
                  icon: Icons.settings_outlined,
                  title: 'Settings',
                ),
                ProfileMenuItem(
                  icon: Icons.help_outline,
                  title: 'Help Center',
                ),
                ProfileMenuItem(
                  icon: Icons.privacy_tip_outlined,
                  title: 'Privacy Policy',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: TColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: TColors.primary,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: Colors.grey,
      ),
      onTap: onTap,
    );
  }
}