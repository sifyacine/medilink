import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/helpers/helper_functions.dart';


/// Reusable Profile Menu Tile
class ProfileMenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isLogout;

  const ProfileMenuTile(
      {super.key,
        required this.icon,
        required this.title,
        this.isLogout = false});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return ListTile(
      leading: Icon(icon, color: isLogout ? Colors.red : TColors.primary),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: isLogout
              ? Colors.red
              : isDark
              ? Colors.white
              : Colors.black,
        ),
      ),
      trailing:
      const Icon(Icons.keyboard_arrow_right_sharp, color: Colors.grey),
      onTap: () {
        if (isLogout) {
          // Handle logout
        }
      },
    );
  }
}
