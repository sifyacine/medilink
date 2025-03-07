import 'package:flutter/material.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/helpers/helper_functions.dart';

/// Reusable Profile Menu Tile
class ProfileMenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isLogout;
  final VoidCallback? onPressed;

  const ProfileMenuTile({
    super.key,
    required this.icon,
    required this.title,
    this.isLogout = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return ListTile(
      leading: Icon(icon, color: isLogout ? Colors.red : TColors.primary),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: isLogout ? Colors.red : isDark ? Colors.white : Colors.black,
        ),
      ),
      trailing: const Icon(Icons.keyboard_arrow_right_sharp, color: Colors.grey),
      onTap: () {
        if (isLogout) {
          // Show logout confirmation popup
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Confirm Logout"),
                content: const Text("Are you sure you want to logout?"),
                actions: [
                  TextButton(
                    child: const Text("Cancel", style: TextStyle(color: TColors.primary),),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  TextButton(
                    child: const Text(
                      "Logout",
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      // Execute the provided onPressed callback if available
                      if (onPressed != null) {
                        onPressed!();
                      }
                    },
                  ),
                ],
              );
            },
          );
        } else {
          // Execute the provided onPressed callback for non-logout actions
          if (onPressed != null) {
            onPressed!();
          }
        }
      },
    );
  }
}
