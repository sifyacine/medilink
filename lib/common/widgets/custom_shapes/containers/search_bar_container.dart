import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';

class TSearchContainer extends StatelessWidget {
  const TSearchContainer({
    super.key,
    required this.text,
    this.icon,
    this.showBackground = true,
    this.showBorder = true,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final void Function()? onTap;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final Color bgColor = showBackground
        ? (isDark ? TColors.dark : Colors.white)
        : Colors.transparent;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        // use padding as outer margin
        margin: padding,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: TSizes.md,
          vertical: TSizes.sm,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
          // hide border by matching its color to the bg
          border: showBorder ? Border.all(color: bgColor) : null,

        ),
        child: Row(
          children: [
            Icon(
              icon ?? Iconsax.search_normal,
              color: TColors.primary,
            ),
            const SizedBox(width: TSizes.spaceBtwItems),
            Expanded(
              child: Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: TColors.darkGrey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
