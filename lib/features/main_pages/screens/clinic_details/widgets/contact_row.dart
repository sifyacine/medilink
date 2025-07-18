import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';

class ContactRow extends StatelessWidget {
  final IconData icon;
  final String value;
  const ContactRow({Key? key, required this.icon, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: TColors.primary),
        const SizedBox(width: 8),
        Expanded(child: Text(value)),
      ],
    );
  }
}