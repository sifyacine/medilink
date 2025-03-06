import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:midilink/features/authentication/screens/signup/signup.dart';
import 'package:midilink/navigation_menu.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/login/login_controller.dart';
import '../../password_configuration/forget_password.dart';

class TLoginForm extends StatelessWidget {
  const TLoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
        child: Column(
          children: [
            /// Email Field
            TextFormField(
              controller: controller.email,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: 'Enter your email',
                hintText: 'Enter your email',
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Email is required';
                }
                if (!GetUtils.isEmail(value.trim())) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),

            /// Password Field
            Obx(
                  () => TextFormField(
                controller: controller.password,
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Iconsax.lock),
                  labelText: 'Enter your password',
                  hintText: 'Enter your password',
                  suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value =
                    !controller.hidePassword.value,
                    icon: Icon(
                      controller.hidePassword.value
                          ? Iconsax.eye_slash
                          : Iconsax.eye,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Password is required';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields / 2),

            /// Forgot Password
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Get.to(() => const ForgetPassword()),
                child: const Text(
                  'Forgot password?',
                  style: TextStyle(
                    color: TColors.primary,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            /// Sign In Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => const NavigationMenu());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: TColors.primary,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Login',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            /// Create Account Text
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account? "),
                GestureDetector(
                  onTap: () {
                    Get.off(() => const SignUpScreen());
                  },
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                      color: TColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            /// Divider
            Row(
              children: [
                Expanded(child: Divider()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text('OR'),
                ),
                Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            /// Social Login Buttons
            Column(
              children: [
                SocialLoginButton(
                  text: 'Sign in with Google',
                  asset: 'assets/logos/google-icon.png',
                ),
                SocialLoginButton(
                  text: 'Sign in with Apple',
                  asset: 'assets/logos/apple-logo.png',
                ),
                SocialLoginButton(
                  text: 'Sign in with Facebook',
                  asset: 'assets/logos/facebook-icon.png',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SocialLoginButton extends StatelessWidget {
  final String text;
  final String asset;

  const SocialLoginButton({
    required this.text,
    required this.asset,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          side: BorderSide(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(asset, height: 20),
            SizedBox(width: 10),
            Text(text),
          ],
        ),
      ),
    );
  }
}