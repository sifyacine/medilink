import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../controllers/onboarding/onboarding_controller.dart';

class OnBoardNavigation extends StatelessWidget {
  const OnBoardNavigation({
  super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;

    return Positioned(
      bottom: TDeviceUtils.getBottomNavigationBarHeight() + 25,
      left: TSizes.defaultSpace,
      child: SmoothPageIndicator(
        effect: const ExpandingDotsEffect(
            activeDotColor: TColors.primary , dotHeight: 6),
        controller: controller.pagecontroller,
        onDotClicked: controller.dotNavigationClick,
        count: 3,
      ),
    );
  }
}