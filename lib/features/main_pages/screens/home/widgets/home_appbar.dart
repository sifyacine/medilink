import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medilink/utils/constants/colors.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/icon/notification_icon_button.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class THomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const THomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final textTheme = Theme.of(context).textTheme;

    return TAppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: (){},
            borderRadius: BorderRadius.circular(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Location',
                  style: textTheme.bodySmall?.copyWith(fontSize: 10),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Iconsax.location5,
                      color: TColors.primary,
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Djelida, Ain-Defla',
                      style: textTheme.titleSmall,
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: isDark ? TColors.light : TColors.dark,
                      size: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
          NotificationIconButton(
            notificationCount: 5,
            onPressed: (){},
          ),
        ],
      ),
    );
  }


  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
