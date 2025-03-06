
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:midilink/features/authentication/screens/onboarding/widgets/onboard_next_button.dart';
import 'package:midilink/features/authentication/screens/onboarding/widgets/onboarding_navigator.dart';
import 'package:midilink/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:midilink/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../controllers/onboarding/onboarding_controller.dart';


class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());

    return Scaffold(
      body: Stack(
        children: [
          /// Horizontal Scrollable pages
          PageView(
            controller: controller.pagecontroller,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                title: "",
                subtitle: "",
                name: TImages.onBoardingImage1,
              ),
              OnBoardingPage(
                title: "",
                subtitle: "",
                name: TImages.onBoardingImage2,
              ),
              OnBoardingPage(
                title: "",
                subtitle: "",
                name: TImages.onBoardingImage3,
              ),
            ],
          ),

          /// Skip Button
          const OnBoardingSkip(),

          /// Dot Navigation SmoothPageIndicator
          const OnBoardNavigation(),

          /// circular button
          const OnBoardingNextButton()
        ],
      ),
    );
  }
}

