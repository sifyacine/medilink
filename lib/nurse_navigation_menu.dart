import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medilink/features/personalization/screens/settings/settings.dart';
import 'package:medilink/utils/constants/colors.dart';
import 'package:medilink/utils/helpers/helper_functions.dart';

import 'features/chat/screens/main_chat/conversations_page.dart';
import 'features/main_pages/screens/apointments/planning_page.dart';
import 'features/main_pages/screens/home/home.dart';
import 'features/main_pages/screens/reservation/reservation_page.dart';
import 'features/nurse_pages/screens/earnings/earnings_page.dart';
import 'features/nurse_pages/screens/home/home_screen.dart';
import 'features/nurse_pages/screens/request_page.dart';
import 'features/personalization/screens/profile/profile.dart';

class NurseNavigationMenu extends StatelessWidget {
  const NurseNavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(NavigationController());
    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: isDark ? TColors.dark : TColors.light,
          currentIndex: controller.selectedIndex.value,
          onTap: (index) {
            controller.selectedIndex.value = index;
          },
          showSelectedLabels: false,
          // Hides the label for selected item
          showUnselectedLabels: false,
          // Hides the label for unselected items
          selectedItemColor: TColors.primary,
          // Changes the color of selected item
          unselectedItemColor: isDark ? Colors.white : Colors.grey,
          // Color for unselected items
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Iconsax.home),
              label: '', // No label
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.note),
              label: '', // No label
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.dollar_circle),
              label: '', // No label
            ),

            BottomNavigationBarItem(
              icon: Icon(Iconsax.user),
              label: '', // No label
            ),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    NurseHomeScreen(),
    BrowseRequestScreen(),
    NurseMainPage(),
    SettingsPage(),
  ];
}
