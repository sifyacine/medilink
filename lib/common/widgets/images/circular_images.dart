import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:medilink/utils/loaders/shimmer_loader.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class TCircularImage extends StatelessWidget {
  const TCircularImage({
    Key? key,
    this.width = 56,
    this.height = 56,
    this.padding = TSizes.sm,
    required this.image,
    this.backgroundColor,
    this.overlayColor,
    this.fit = BoxFit.cover,
    this.isNetworkImage = false,
  }) : super(key: key);

  final double width, height, padding;
  final String image;
  final Color? backgroundColor;
  final Color? overlayColor;
  final BoxFit fit;
  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color:
            backgroundColor ??
            (THelperFunctions.isDarkMode(context)
                ? TColors.black
                : TColors.white),
        borderRadius: BorderRadius.circular(100),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(56),
        child: Center(
          child:
              isNetworkImage
                  ? CachedNetworkImage(
                    imageUrl: image,
                    fit: fit,
                    color: overlayColor,
                    progressIndicatorBuilder:
                        (context, url, downLoadProgress) => const TShimmerEffect(
                          width: 56,
                          height: 56,
                          radius: 56,
                        ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  )
                  : Image(
                    image:
                        isNetworkImage
                            ? NetworkImage(image)
                            : AssetImage(image) as ImageProvider,
                    fit: fit,
                    color: overlayColor,
                    colorBlendMode: BlendMode.srcOver,
                  ),
        ),
      ),
    );
  }
}
