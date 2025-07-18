
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink/features/authentication/screens/onboarding/widgets/onboard_next_button.dart';
import 'package:medilink/features/authentication/screens/onboarding/widgets/onboarding_navigator.dart';
import 'package:medilink/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:medilink/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../controllers/onboarding/onboarding_controller.dart';


class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

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
            children: [
              OnBoardingPage(
                title: "Select Your Healthcare Service",
                subtitle: "Discover a range of medical solutions – clinics, pharmacies, and telehealth consultations all in one app!",
                name: TImages.onBoardingImage1,
              ),
              OnBoardingPage(
                title: "Book & Pay Securely",
                subtitle: "Easily schedule appointments and manage payments with our secure, hassle-free system.",
                name: TImages.onBoardingImage2,
              ),
              OnBoardingPage(
                title: "Receive Care at Your Convenience",
                subtitle: "Whether in-person or online, experience swift and professional care tailored to your needs.",
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

