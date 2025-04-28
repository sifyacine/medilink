import 'package:flutter/material.dart';
import '../../images/rounded_images.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../texts/brandicon_verify_button.dart';
import '../../texts/product_title_text.dart';


class TCartItem extends StatelessWidget {
  const TCartItem({
  super.key, required this.productTitle, required this.pharmacyName, required this.productImage, required this.productDosage,
  });
  final String productTitle;
  final String pharmacyName;
  final String productImage;
  final String productDosage;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return Row(
      children: [
        TRoundedImage(

          imageUrl: productImage,

          width: 60,
          height: 60,
          padding: const EdgeInsets.all(0),
          backgroundColor: isDark ? TColors.darkGrey : TColors.light,
        ),
        const SizedBox(width: TSizes.spaceBtwItems),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TBrandTitleWithVerifiedIcon(title: pharmacyName),
              Flexible(
                child: TProductTitleText(title: productTitle),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Dosage ',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    TextSpan(
                      text: productDosage,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}