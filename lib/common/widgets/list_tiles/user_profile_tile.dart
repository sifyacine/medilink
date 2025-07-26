import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medilink/features/personalization/controllers/user_controller.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/loaders/shimmer_loader.dart';
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
      title: Text(controller.user.value.fullName, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      subtitle: GestureDetector(onLongPress: (){}, child: Text(controller.user.value.email, style: TextStyle(color: Colors.white, fontSize: 10))),
      trailing: IconButton(onPressed: onPressed, icon: const Icon(Iconsax.edit, color: TColors.white,),),
      leading:Obx(() {
        final networkImage = controller.user.value.profilePicUrl;
        final image = networkImage!.isNotEmpty ? networkImage : TImages.user;
        return controller.imageUpLoading.value ?
        TShimmerEffect(width: 56, height: 56, radius: 56,)
            :TCircularImage(
          isNetworkImage: networkImage.isNotEmpty,
          image: image,
          width: 56,
          height: 56,
        );
      }),
    );
  }
}