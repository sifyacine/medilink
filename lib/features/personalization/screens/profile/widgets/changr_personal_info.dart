import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/update_user_information.dart';


class UpdatePersonalInfoScreen extends StatelessWidget {
  const UpdatePersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdatePersonalInfoController());

    return Scaffold(
      appBar: TAppBar(title: const Text("Edit Personal Information"), showBackArrow: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Form(
          key: controller.personalInfoFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Gender Dropdown
              DropdownButtonFormField<String>(
                value: controller.gender.value.isNotEmpty ? controller.gender.value : null,
                decoration: const InputDecoration(labelText: 'Gender'),
                items: controller.genderOptions
                    .map((gender) => DropdownMenuItem(value: gender, child: Text(gender)))
                    .toList(),
                onChanged: (value) => controller.gender.value = value ?? '',
              ),

              const SizedBox(height: TSizes.spaceBtwInputFields),

              /// Address
              TextFormField(
                controller: controller.address,
                decoration: const InputDecoration(labelText: 'Address'),
              ),

              const SizedBox(height: TSizes.spaceBtwInputFields),

              /// Blood Type
              DropdownButtonFormField<String>(
                value: controller.bloodType.value.isNotEmpty ? controller.bloodType.value : null,
                decoration: const InputDecoration(labelText: 'Blood Type'),
                items: controller.bloodTypeOptions
                    .map((blood) => DropdownMenuItem(value: blood, child: Text(blood)))
                    .toList(),
                onChanged: (value) => controller.bloodType.value = value ?? '',
              ),

              const SizedBox(height: TSizes.spaceBtwInputFields),

              /// Date of Birth Picker
              InkWell(
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: controller.dateOfBirth.value ?? DateTime(2000),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    controller.dateOfBirth.value = pickedDate;
                  }
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Date of Birth'),
                  child: Obx(() {
                    final dob = controller.dateOfBirth.value;
                    return Text(
                      dob != null ? DateFormat('yyyy-MM-dd').format(dob) : 'Select Date',
                      style: TextStyle(color: dob != null ? Colors.black : Colors.grey),
                    );
                  }),
                ),
              ),

              const SizedBox(height: TSizes.spaceBtwInputFields),

              /// State Dropdown
              Obx(() => DropdownButtonFormField<String>(
                value: controller.state.value.isNotEmpty ? controller.state.value : null,
                decoration: const InputDecoration(labelText: 'State'),
                items: controller.states
                    .map((state) => DropdownMenuItem(value: state, child: Text(state)))
                    .toList(),
                onChanged: (value) {
                  controller.onStateSelected(value!);
                },
              )),

              const SizedBox(height: TSizes.spaceBtwInputFields),

              /// City Dropdown
              Obx(() => DropdownButtonFormField<String>(
                value: controller.city.value.isNotEmpty ? controller.city.value : null,
                decoration: const InputDecoration(labelText: 'City'),
                items: controller.cities
                    .map((city) => DropdownMenuItem(value: city, child: Text(city)))
                    .toList(),
                onChanged: (value) => controller.city.value = value ?? '',
              )),

              const SizedBox(height: TSizes.spaceBtwSections),

              /// Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controller.updatePersonalInfo(),
                  child: const Text("Save Changes"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
