import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/text_strings.dart';


class THomeAppBar extends StatelessWidget {
  const THomeAppBar({
  super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TAppBar(title: Text("all services for your health", style: Theme.of(context).textTheme.headlineSmall!.apply(color: TColors.white),),
      actions: [
        IconButton(onPressed: (){}, icon: const Icon(Iconsax.notification))
      ],
    );
  }
}