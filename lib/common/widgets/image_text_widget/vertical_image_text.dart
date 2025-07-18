import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class TVerticalTextImage extends StatelessWidget {
  final String image, title;
  final Color textColor;
  final Color? backgroundColor;
  final void Function()? onTap;

  const TVerticalTextImage({
    super.key,
    required this.image,
    required this.title,
    this.textColor = TColors.white,
    this.backgroundColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: TSizes.spaceBtwItems),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(TSizes.sm),
              height: 64,
              width: 64,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color:
                    backgroundColor ?? (isDark ? TColors.primary.withAlpha(46) : TColors.primary.withAlpha(36)),
              ),
              child: Center(
                child:
                    image.toLowerCase().endsWith('.svg')
                        ? SvgPicture.asset(image, width: 40, height: 40)
                        : Image.asset(
                          image,
                          fit: BoxFit.cover,
                        ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            SizedBox(
              width: 60,
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(color: textColor, fontSize: 8),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
