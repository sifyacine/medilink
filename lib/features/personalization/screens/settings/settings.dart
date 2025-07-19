
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medilink/data/repositories/authentication_repository.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/list_tiles/settings_menu_tile.dart';
import '../../../../common/widgets/list_tiles/user_profile_tile.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../main_pages/screens/cart/cart.dart';
import '../address/addresses.dart';
import '../profile/profile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthenticationRepository());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// header
            TPrimaryHeaderContainer(
                child: Column(
              children: [
                /// appBar
                TAppBar(
                  title: Text(
                    'Account',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .apply(color: TColors.white),
                  ),
                ),

                /// user profile picture
                TUserProfileTile(onPressed: () => Get.to(() => const ProfileScreen()),),
              ],
            )),

            /// list of settings menu (body)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: TSizes.defaultSpace, horizontal: 12),
              child: Column(
                children: [
                  /// account settings
                  const TSectionHeading(title: 'Account Settings', showActionButton: false,),
                  const SizedBox(height: TSizes.spaceBtwItems,),

                  TSettingsMenuTile(icon: Iconsax.safe_home,title: 'My Addresses', subtitle: 'Set shopping delivery address', onTab: (){ Get.to(() => const AddressesScreen());},),
                  TSettingsMenuTile(icon: Iconsax.shopping_cart,title: 'My Cart', subtitle: 'Add remove products and move to checkout', onTab: (){ Get.to(() => const CartScreen());},),
                  TSettingsMenuTile(icon: Iconsax.bag_tick,title: 'My Orders', subtitle: 'In-progress and completed orders ', onTab: (){ Get.to(() => Container());},),
                  TSettingsMenuTile(icon: Iconsax.bank,title: 'Bank Account', subtitle: 'Withdraw balance to registered bank account', onTab: (){},),
                  TSettingsMenuTile(icon: Iconsax.discount_shape ,title: 'My Coupons', subtitle: 'List of all discount coupons', onTab: (){},),
                  TSettingsMenuTile(icon: Iconsax.notification ,title: 'Notifications', subtitle: 'Set any kind of notification messages', onTab: (){},),
                  TSettingsMenuTile(icon: Iconsax.security_card ,title: 'Account Privacy', subtitle: 'Manage data usage and connected accounts', onTab: (){},),

                  /// app settings
                  const SizedBox(height: TSizes.spaceBtwSections,),
                  const TSectionHeading(title: 'App Settings', showActionButton: false,),
                  const SizedBox(height: TSizes.spaceBtwItems,),
                  TSettingsMenuTile(icon: Iconsax.document_upload ,title: 'Load data', subtitle: 'Upload data to your cloud firebase', onTab: (){},),
                  TSettingsMenuTile(icon: Iconsax.location ,title: 'Geolocation', subtitle: 'USet recommendation based on location  ', onTab: (){}, trailing: Switch(value: true, onChanged: (value){},),),
                  TSettingsMenuTile(icon: Iconsax.security_user ,title: 'Safe Mode', subtitle: 'Search results are safe for all ages ', onTab: (){}, trailing: Switch(value: false, onChanged: (value){},),),
                  TSettingsMenuTile(icon: Iconsax.image ,title: 'HD image quality', subtitle: 'Set image quality to be seen ', onTab: (){}, trailing: Switch(value: false, onChanged: (value){},),),
                  /// logout button
                  TextButton(
                    onPressed: () {
                      // Show confirmation dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Confirm Logout"),
                            content:
                            const Text("Are you sure you want to log out?"),
                            actions: [
                              TextButton(
                                child: const Text("Cancel",
                                    style: TextStyle(color: Colors.grey)),
                                onPressed: () {
                                  // Close the dialog without logging out
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: const Text("Logout",
                                    style:
                                    TextStyle(color: TColors.primary)),
                                onPressed: () {
                                  // Call the logout method from your controller
                                  authController.logOut();
                                  // Close the dialog
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text(
                      "Log out",
                      style:
                      TextStyle(fontSize: 18.0, color: TColors.primary),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
