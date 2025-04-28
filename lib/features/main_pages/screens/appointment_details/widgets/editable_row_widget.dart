import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class EditableRowWidget extends StatelessWidget {
  final String title;
  final String Function() value;
  final VoidCallback onEdit;

  const EditableRowWidget({
    Key? key,
    required this.title,
    required this.value,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Wrap only the part that depends on reactive data in Obx
    final isDark = THelperFunctions.isDarkMode(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Title and value
        Expanded(
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                Text(value(), style: TextStyle(color: isDark? TColors.light : TColors.dark,)),
              ],
            );
          }),
        ),
        // "Modifier" button
        InkWell(
          onTap: onEdit,
          child: Text(
            'update',
            style: TextStyle(
              color: TColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
