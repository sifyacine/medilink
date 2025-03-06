import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:midilink/utils/constants/colors.dart';
import 'package:midilink/utils/helpers/helper_functions.dart';

import 'features/personalization/screens/profile/profile_screen.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

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
              icon: Icon(Iconsax.calendar),
              label: '', // No label
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.message),
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
    const HomeScreen(),
    const MessagesScreen(),
    const CalendarScreen(),
    const ProfileScreen(),
  ];
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("🏠 Home Screen"),
    );
  }
}

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("📩 Messages Screen"),
    );
  }
}

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("📅 Calendar Screen"),
    );
  }
}