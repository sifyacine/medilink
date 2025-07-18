import 'package:flutter/material.dart';

/// A thumbnail for your gallery strip.
///
/// You can pass in a [border] (e.g. `Border.all(color: TColors.primary, width: 2)`)
/// to highlight whichever one is selected, and an [onTap] callback if you
/// want to handle taps here rather than wrapping this widget.
class GalleryThumbnail extends StatelessWidget {
  final String assetPath;
  final BoxBorder? border;
  final VoidCallback? onTap;

  const GalleryThumbnail(
      this.assetPath, {
        Key? key,
        this.border,
        this.onTap,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: border,
          ),
          clipBehavior: Clip.hardEdge,
          child: Image.asset(
            assetPath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
