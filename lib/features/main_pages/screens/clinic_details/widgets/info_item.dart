
import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';

class InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  const InfoItem({Key? key, required this.icon, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: TColors.primary),
        const SizedBox(width: 4),
        Text(label),
      ],
    );
  }
}