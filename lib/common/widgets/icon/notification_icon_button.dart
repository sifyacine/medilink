import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class NotificationIconButton extends StatelessWidget {
  final int notificationCount;
  final VoidCallback onPressed;
  final IconData icon;
  final double iconSize;

  const NotificationIconButton({
    Key? key,
    required this.notificationCount,
    required this.onPressed,
    this.icon = Iconsax.notification,
    this.iconSize = 24.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none, // Allow badge to overflow the stack boundary.
      children: [
        IconButton(
          icon: Icon(icon, size: iconSize),
          onPressed: onPressed,
        ),
        if (notificationCount > 0)
          Positioned(
            right: 6,
            top: 6,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              child: Center(
                child: Text(
                  '$notificationCount',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
