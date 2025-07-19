import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medilink/features/personalization/controllers/user_controller.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../images/circular_images.dart';


class TUserProfileTile extends StatelessWidget {
  const TUserProfileTile({
  super.key, required this.onPressed,
  });

  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    Get.put(UserController());
    final controller = UserController.instance;
    return ListTile(
      title: Text(controller.user.value.fullName, style: TextStyle(color: Colors.white)),
      subtitle: Text(controller.user.value.email, style: TextStyle(color: Colors.white)),
      trailing: IconButton(onPressed: onPressed, icon: const Icon(Iconsax.edit, color: TColors.white,),),
      leading: const TCircularImage(
        image: TImages.user,
        height: 50,
        width: 50,
        padding: 0,
      ),
    );
  }
}