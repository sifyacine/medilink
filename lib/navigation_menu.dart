import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:midilink/utils/constants/colors.dart';
import 'package:midilink/utils/helpers/helper_functions.dart';


class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(NavigationController());
    return Scaffold(
      bottomNavigationBar: Obx(
            () => NavigationBar(
          height: 80,
          backgroundColor: isDark ? TColors.dark : TColors.light,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: ''),
            NavigationDestination(icon: Icon(Iconsax.message), label: ''),
            NavigationDestination(icon: Icon(Iconsax.calendar), label: ''),
            NavigationDestination(icon: Icon(Iconsax.user), label: ''),
          ],
        ),
      ),
      body: Obx(() =>  controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    Container(),
    Container(),
    Container(),
    Container(),
  ];

}


