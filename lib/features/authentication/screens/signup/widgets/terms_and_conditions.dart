import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/signup/signup_controller.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = SignupController.instance;
    return           Row(
      children: [
        Obx(
              () => Checkbox(
            value: controller.privacyPolicy.value,
            onChanged: (value) => controller.privacyPolicy.value = value ?? false,
            activeColor: TColors.primary,
          ),
        ),
        Expanded(
          child: Wrap(
            children: [
              const Text(
                "I accept the ",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              GestureDetector(
                onTap: () {
                  // Handle Terms of Use Click
                },
                child: Text(
                  "Terms of Use",
                  style: TextStyle(fontSize: 12, color: TColors.primary, fontWeight: FontWeight.bold),
                ),
              ),
              const Text(
                " and ",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              GestureDetector(
                onTap: () {
                  // Handle Privacy Policy Click
                },
                child: Text(
                  "Privacy Policy",
                  style: TextStyle(fontSize: 12, color: TColors.primary, fontWeight: FontWeight.bold),
                ),
              ),
              const Text(
                " of Medilink",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
