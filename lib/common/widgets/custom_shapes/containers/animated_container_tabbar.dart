import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';

class SelectableOption extends StatelessWidget {
  const SelectableOption({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
    this.selectedColor = TColors.primary,
    this.unselectedColor = Colors.transparent,
    this.selectedTextColor = Colors.white,
    this.unselectedTextColor,
    this.borderRadius = TSizes.borderRadiusMd,
    this.duration = const Duration(milliseconds: 200),
    this.padding = const EdgeInsets.symmetric(vertical: 14),
  });

  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final Color selectedColor;
  final Color unselectedColor;
  final Color selectedTextColor;
  final Color? unselectedTextColor;
  final double borderRadius;
  final Duration duration;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final effectiveUnselectedTextColor = unselectedTextColor ??
        (isDark ? Colors.grey.shade400 : Colors.grey.shade700);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: duration,
        padding: padding,
        decoration: BoxDecoration(
          color: isSelected ? selectedColor : unselectedColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? selectedTextColor : effectiveUnselectedTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}