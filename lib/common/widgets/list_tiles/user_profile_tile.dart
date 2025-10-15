import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medilink/features/personalization/controllers/user_controller.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/loaders/shimmer_loader.dart';
import '../images/circular_images.dart';


class TUserProfileTile extends StatelessWidget {
  const TUserProfileTile({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());

    return Obx(() {
      final networkImage = controller.user.value.profilePicUrl ?? '';
      final image = networkImage.isNotEmpty ? networkImage : TImages.user;
      final fullName = controller.user.value.fullName;
      final email = controller.user.value.email;

      return ListTile(
        title: Text(
            fullName.isNotEmpty ? fullName : 'Loading...',
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
            )
        ),
        subtitle: Text(
            email.isNotEmpty ? email : 'Loading...',
            style: const TextStyle(
                color: Colors.white,
                fontSize: 10
            )
        ),
        trailing: IconButton(
          onPressed: onPressed,
          icon: const Icon(Iconsax.edit, color: TColors.white),
        ),
        leading: controller.imageUpLoading.value
            ? const TShimmerEffect(width: 56, height: 56, radius: 56)
            : TCircularImage(
          isNetworkImage: networkImage.isNotEmpty,
          image: image,
          width: 56,
          height: 56,
        ),
      );
    });
  }
}