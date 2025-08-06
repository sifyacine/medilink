


import 'package:flutter/cupertino.dart';

import '../../../utils/constants/sizes.dart';
import '../../../utils/loaders/shimmer_loader.dart';

class TCategoryShimmer extends StatelessWidget {
  const TCategoryShimmer({
    super.key,
    this.itemCount = 5,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: itemCount,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, __) => SizedBox(width: TSizes.spaceBtwItems),
        itemBuilder: (_, __) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image shimmer
              TShimmerEffect(width: 55, height: 55, radius: 55),
              SizedBox(height: TSizes.spaceBtwItems / 2),

              // Text shimmer
              TShimmerEffect(width: 55, height: 8),
            ],
          );
        },
      ),
    );
  }
}
