import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medilink/features/authentication/screens/signup/widgets/terms_and_conditions.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controllers/signup/nurse_controller.dart';

class NurseSignUpForm extends StatelessWidget {
  const NurseSignUpForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NurseSignupController());
    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          /// first and last name
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  validator: (value) => TValidator.validateFullName(value),
                  controller: controller.firstName,
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: TTexts.firstName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
              const SizedBox(width: TSizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  validator: (value) => TValidator.validateFullName(value),
                  controller: controller.lastName,
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: TTexts.lastName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          /// user name
          TextFormField(
            validator: (value) => TValidator.validateUsername(value),
            controller: controller.userName,
            expands: false,
            decoration: const InputDecoration(
              labelText: TTexts.username,
              prefixIcon: Icon(Iconsax.user_edit),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          /// email
          TextFormField(
            validator: (value) => TValidator.validateEmail(value),
            controller: controller.email,
            expands: false,
            decoration: const InputDecoration(
              labelText: TTexts.email,
              prefixIcon: Icon(Iconsax.direct),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          /// phone number
          TextFormField(
            validator: (value) => TValidator.validatePhoneNumber(value),
            controller: controller.phoneNumber,
            decoration: const InputDecoration(
              labelText: TTexts.phoneNo,
              prefixIcon: Icon(Iconsax.call),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          /// license number
          TextFormField(
            controller: controller.licenseNumber,
            decoration: const InputDecoration(
              labelText: 'License Number',
              prefixIcon: Icon(Iconsax.document),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          /// specialization
          TextFormField(
            controller: controller.specialization,
            decoration: const InputDecoration(
              labelText: 'Specialization',
              prefixIcon: Icon(Iconsax.health),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          /// workplace
          TextFormField(
            controller: controller.workplace,
            decoration: const InputDecoration(
              labelText: 'Workplace',
              prefixIcon: Icon(Iconsax.building),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          /// password
          Obx(
                () => TextFormField(
              validator: (value) => TValidator.validatePassword(value),
              controller: controller.password,
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                labelText: TTexts.password,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye,
                  ),
                  onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                ),
              ),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          /// terms and conditions checkbox
          const TermsAndConditions(),

          /// signup button
          const SizedBox(height: TSizes.spaceBtwSections),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.signup(),
              child: const Text('Sign Up as Nurse'),
            ),
          ),
        ],
      ),
    );
  }
}