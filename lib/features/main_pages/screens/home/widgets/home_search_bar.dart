import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';


class TSearchContainer extends StatefulWidget {
  const TSearchContainer({
    super.key,
    required this.hintText,
    this.icon,
    this.showBackground = true,
    this.showBorder = true,
    this.onChanged,
    this.onSubmitted,
    this.padding = const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
  });

  final String hintText;
  final IconData? icon;
  final bool showBackground, showBorder;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final EdgeInsetsGeometry padding;

  @override
  State<TSearchContainer> createState() => _TSearchContainerState();
}

class _TSearchContainerState extends State<TSearchContainer> {
  final TextEditingController _controller = TextEditingController();
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final bgColor = widget.showBackground
        ? (isDark ? TColors.dark : TColors.light)
        : Colors.transparent;
    final borderColor = TColors.primary;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: TSizes.md,
        vertical: TSizes.sm,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Icon(widget.icon ?? Iconsax.search_normal, color: TColors.primary),
          const SizedBox(width: TSizes.spaceBtwItems),
          Expanded(
            child: Focus(
              onFocusChange: (hasFocus) =>
                  setState(() => _focused = hasFocus),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  hintText: widget.hintText,
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: TColors.primary),

                  // remove default underline:
                  border: InputBorder.none,

                  // the “resting” state border
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
                    borderSide: BorderSide(color: isDark ? TColors.dark : TColors.light, width: 1),
                  ),

                  // the focus state border
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
                    borderSide: BorderSide(color: isDark ? TColors.dark : TColors.light, width: 2),
                  ),

                  // if you want a “disabled” look
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
                    borderSide: BorderSide(color: isDark ? TColors.dark : TColors.light),
                  ),
                ),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: isDark ? Colors.white : Colors.black),
                onChanged: widget.onChanged,
                onSubmitted: widget.onSubmitted,
              ),

            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
