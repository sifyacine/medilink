import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:midilink/utils/helpers/helper_functions.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/text_strings.dart';


class THomeAppBar extends StatelessWidget {
  const THomeAppBar({
  super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return TAppBar(title: Column(
      children: [
        Text("All services for your health ", style: Theme.of(context).textTheme.headlineSmall!.apply(color: isDark? TColors.white : TColors.black),),
      ],
    ),

    );
  }
}