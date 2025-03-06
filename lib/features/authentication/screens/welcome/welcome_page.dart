import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:midilink/features/authentication/screens/login/login_screen.dart';
import 'package:midilink/features/authentication/screens/signup/signup.dart';
import 'package:midilink/utils/constants/image_strings.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';


class WelcomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo and Title
              Column(
                children: [
                  Image.asset(TImages.appLogo, height: 80), // Replace with your actual image asset
                  SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                      children: [
                        TextSpan(text: 'Medi', style: TextStyle(color: isDark? TColors.white : TColors.black)),
                        TextSpan(
                          text: 'link',
                          style: TextStyle(color: TColors.primary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Subtitle
              Text(
                "Let's get started!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "Log in to enjoy the features we offer and stay healthy!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
              SizedBox(height: 30),

              // Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(()=> const LoginScreen());
                  }, // Implement navigation or functionality
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text("Log In", style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Get.to(() => const SignUpScreen());
                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    side: BorderSide(color: TColors.primary),
                  ),
                  child: Text("Sign Up", style: TextStyle(fontSize: 16, color: TColors.primary)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
