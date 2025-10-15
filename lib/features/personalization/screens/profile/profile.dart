import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medilink/features/personalization/screens/profile/widgets/change_name.dart';
import 'package:medilink/features/personalization/screens/profile/widgets/changr_personal_info.dart';
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
    final controller = Get.put(UserController());

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
                      final networkImage = controller.user.value.profilePicUrl ?? '';
                      final image = networkImage.isNotEmpty ? networkImage : TImages.user;

                      return controller.imageUpLoading.value
                          ? const TShimmerEffect(width: 80, height: 80, radius: 80)
                          : TCircularImage(
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

              Obx(() => TProfileMenu(
                onPressed: () {},
                title: 'Name',
                value: controller.user.value.fullName ?? 'N/A',
              )),
              Obx(() => TProfileMenu(
                onPressed: () => Get.to(() => ChangeName()),
                title: 'Username',
                value: controller.user.value.username ?? 'N/A',
              )),
              Obx(() => TProfileMenu(
                onPressed: () {},
                title: 'E-mail',
                value: controller.user.value.email ?? 'N/A',
              )),
              Obx(() => TProfileMenu(
                onPressed: () {},
                title: 'Phone Number',
                value: controller.user.value.phoneNumber ?? 'N/A',
              )),

              const SizedBox(height: TSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              ///heading personal info
              TSectionHeading(
                title: "Personal information",
                showActionButton: true,
                buttonTitle: "update",
                onPressed: () => Get.to(() => UpdatePersonalInfoScreen()),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              Obx(() => TProfileMenu(
                title: 'Gender',
                value: controller.user.value.gender?.toString() ?? 'N/A',
              )),
              Obx(() => TProfileMenu(
                title: 'Address',
                value: controller.user.value.address?.toString() ?? 'N/A',
              )),
              Obx(() => TProfileMenu(
                title: 'Blood type',
                value: controller.user.value.bloodType?.toString() ?? 'N/A',
              )),
              Obx(() => TProfileMenu(
                title: 'Date Of Birth',
                value: controller.user.value.dateOfBirth?.toString() ?? 'N/A',
              )),
              Obx(() => TProfileMenu(
                title: 'State',
                value: controller.user.value.state?.toString() ?? 'N/A',
              )),
              Obx(() => TProfileMenu(
                title: 'City',
                value: controller.user.value.city?.toString() ?? 'N/A',
              )),
              Obx(() => TProfileMenu(
                title: 'Role',
                value: controller.user.value.role?.toString() ?? 'N/A',
              )),

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