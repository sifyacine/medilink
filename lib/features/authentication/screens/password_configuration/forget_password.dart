import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medilink/features/authentication/screens/password_configuration/reset_password.dart';

import '../../../../common/widgets/custom_shapes/containers/animated_container_tabbar.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/validators/validation.dart';
import '../../controllers/forget_password/forget_password_controller.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    final isDark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Headings
              Text(
                "Forgot Password?",
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text(
                "Enter your email or phone number, and we will send you a confirmation code.",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color:
                          isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                    ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Toggle for Email/Phone selection
              Obx(
                () => Container(
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(TSizes.borderRadiusMd),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: SelectableOption(
                          title: "Email",
                          isSelected: controller.isEmailSelected.value,
                          onTap: controller
                              .selectEmail, // Use the controller method
                        ),
                      ),
                      Expanded(
                        child: SelectableOption(
                          title: "Phone",
                          isSelected: controller.isPhoneSelected.value,
                          // Different boolean
                          onTap: controller.selectPhone, // Different handler
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Input Field for Email or Phone
              Form(
                key: controller.forgetPasswordFormKey,
                child: Obx(
                  () => TextFormField(
                    controller: controller.isEmailSelected.value
                        ? controller.email
                        : controller.phone,
                    validator: controller.isEmailSelected.value
                        ? TValidator.validateEmail
                        : TValidator.validatePhoneNumber,
                    keyboardType: controller.isEmailSelected.value
                        ? TextInputType.emailAddress
                        : TextInputType.phone,
                    style:
                        TextStyle(color: isDark ? Colors.white : Colors.black),
                    decoration: InputDecoration(
                      hintText: controller.isEmailSelected.value
                          ? "Enter your email"
                          : "Enter your phone number",
                      hintStyle: TextStyle(
                          color: isDark
                              ? Colors.grey.shade500
                              : Colors.grey.shade600),
                      filled: true,
                      fillColor:
                          isDark ? Colors.grey.shade800 : Colors.grey.shade100,
                      prefixIcon: Icon(
                        controller.isEmailSelected.value
                            ? Iconsax.message
                            : Iconsax.call,
                        color: TColors.primary,
                      ),
                      suffixIcon:
                          const Icon(Iconsax.check, color: TColors.primary),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(TSizes.borderRadiusMd),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(TSizes.borderRadiusMd),
                    ),
                  ),
                  onPressed: () {
                    Get.off(
                        () => const ResetPassword(email: "ycn585@gmail.com"));
                  },
                  child: const Text(
                    "Reset Password",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
