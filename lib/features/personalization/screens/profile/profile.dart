import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medilink/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:medilink/utils/loaders/shimmer_loader.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/images/circular_images.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/user_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(UserController());
    final controller = UserController.instance;
    return Scaffold(
      /// appbar
      appBar: const TAppBar(title: Text('Profile'), showBackArrow: true),

      /// body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// profile picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(() {
                      final networkImage = controller.user.value.profilePicUrl;
                      final image = networkImage!.isNotEmpty ? networkImage : TImages.user;
                      return controller.imageUpLoading.value ?
                      TShimmerEffect(width: 80, height: 80, radius: 80,)
                          :TCircularImage(
                        isNetworkImage: networkImage.isNotEmpty,
                        image: image,
                        width: 80,
                        height: 80,
                      );
                    }),
                    TextButton(
                      onPressed: () => controller.uploadUserProfilePicture(),
                      child: const Text(
                        'change your profile picture',
                        style: TextStyle(color: TColors.primary),
                      ),
                    ),
                  ],
                ),
              ),

              /// details
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// heading profile info
              const TSectionHeading(title: "Profile Information"),
              const SizedBox(height: TSizes.spaceBtwItems),

              TProfileMenu(
                onPressed: () {},
                title: 'Name',
                value: controller.user.value.fullName,
              ),
              TProfileMenu(
                onPressed: () {},
                title: 'Username',
                value: controller.user.value.username,
              ),

              const SizedBox(height: TSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              ///heading personal info
              const TSectionHeading(title: "Personal information"),
              const SizedBox(height: TSizes.spaceBtwItems),

              TProfileMenu(
                icon: Iconsax.copy,
                title: 'User-ID',
                value: controller.user.value.id,
              ),
              TProfileMenu(
                onPressed: () {},
                title: 'E-mail',
                value: controller.user.value.email,
              ),
              TProfileMenu(
                onPressed: () {},
                title: 'Phone Number',
                value: controller.user.value.phoneNumber,
              ),
              TProfileMenu(
                onPressed: () {},
                title: 'Gender',
                value: controller.user.value.gender.toString(),
              ),
              TProfileMenu(
                onPressed: () {},
                title: 'Date  Of Birth',
                value: controller.user.value.dateOfBirth.toString(),
              ),

              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              Center(
                child: TextButton(
                  onPressed: () => controller.deleteAccountWarningPopup(),
                  child: const Text(
                    'Close Account',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
