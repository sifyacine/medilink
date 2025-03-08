import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/list_tiles/settings_menu_tile.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../controllers/settings_controller.dart';

class SettingsPage extends StatelessWidget {
  final settingsController = Get.put(SettingsController());

  SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final backgroundColor = isDark ? TColors.dark : TColors.light;

    return Scaffold(
      appBar: const TAppBar(
        title: Text('Settings'),
        showBackArrow: true,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            color: backgroundColor,
            child: Column(
              children: [
                Obx(
                      () => TSettingsMenuTile(
                    icon: Iconsax.language_circle,
                    title: 'App Language',
                    subtitle: settingsController.selectedLanguageCode.value.split('_').first,
                    onTab: () => settingsController.showLanguageBottomSheet(context),
                  ),
                ),
                Obx(
                      () => TSettingsMenuTile(
                    icon: Iconsax.moon,
                    title: 'Dark Mode',
                    subtitle: settingsController.selectedThemeMode.value == ThemeMode.system
                        ? 'Follow System'
                        : settingsController.selectedThemeMode.value == ThemeMode.dark
                        ? 'Dark Mode'
                        : 'Light Mode',
                    onTab: () => settingsController.showThemeModeBottomSheet(context),
                  ),
                ),
                TSettingsMenuTile(
                  icon: Iconsax.notification,
                  title: 'Notifications',
                  onTab: () {
                    // Navigate to notifications settings page
                  },
                ),
                TSettingsMenuTile(
                  icon: Iconsax.card, // Changed to a payment-related icon
                  title: 'Payment Methods',
                  onTab: () {
                    // Navigate to payment methods page
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            color: backgroundColor,
            child: Column(
              children: [
                TSettingsMenuTile(
                  icon: Iconsax.user_search,
                  title: 'Invite Friend',
                  onTab: () {
                    // Navigate to invite friend page
                  },
                ),
                TSettingsMenuTile(
                  icon: Iconsax.profile_delete,
                  title: 'Delete Account',
                  onTab: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Confirm Delete Account"),
                          content: const Text(
                            "Are you sure you want to delete your account? This action is irreversible.",
                          ),
                          actions: [
                            TextButton(
                              child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
                              onPressed: () => Get.back(),
                            ),
                            TextButton(
                              child: const Text("Delete", style: TextStyle(color: Colors.red)),
                              onPressed: () {
                                // Delete account logic
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
