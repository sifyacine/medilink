import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink/features/main_pages/controllers/announcement_controller.dart';
import 'package:medilink/features/main_pages/models/announcment_model.dart';
import 'package:medilink/features/main_pages/screens/announcment/widgets/mini_map.dart';

import '../../../../utils/constants/colors.dart';

class AnnouncementFormScreen extends StatelessWidget {
  final Announcement? announcement; // Null for create, non-null for update

  const AnnouncementFormScreen({super.key, this.announcement});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AnnouncementController>();

    // Initialize form with existing announcement data if updating
    if (announcement != null) {
      controller.descriptionController.text = announcement!.additionalNotes;
      controller.startingPointController.text =
          announcement!.startingPoint ?? '';
      controller.endingPointController.text = announcement!.endingPoint ?? '';
      controller.selectedState.value = announcement!.state;
      controller.selectedCity.value = announcement!.city;
      controller.selectedTargetAudience.value = announcement!.targetAudience;
      controller.selectedStartDate.value = announcement!.startDate;
      controller.selectedStartTime.value = announcement!.startTime;
      controller.selectedEndTime.value = announcement!.endTime;
      controller.minAge.value = announcement!.minAge ?? 0;
      controller.maxAge.value = announcement!.maxAge ?? 100;
      controller.isActive.value = announcement!.isActive;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          announcement == null ? 'Create Announcement' : 'Update Announcement',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: TColors.primary,
        centerTitle: true,
      ),
      body: _MultiStepForm(
        announcement: announcement,
        isUpdating: announcement != null,
      ),
    );
  }
}

class _MultiStepForm extends StatelessWidget {
  final Announcement? announcement;
  final bool isUpdating;

  _MultiStepForm({required this.announcement, required this.isUpdating});

  @override
  Widget build(BuildContext context) {
    final RxInt currentStep = 0.obs;

    final List<Widget> steps = [
      LocationStep(),
      DetailsStep(),
      AudienceStep(),
      ConfirmationStep(announcement: announcement, isUpdating: isUpdating),
    ];

    return Column(
      children: [
        // Step Indicator
        Obx(
          () => StepIndicator(
            currentStep: currentStep.value,
            totalSteps: steps.length,
            stepTitles: ['Location', 'Schedule','Details',  'Review'],
          ),
        ),
        Expanded(child: Obx(() => steps[currentStep.value])),
        // Navigation Buttons
        Obx(
          () => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (currentStep.value > 0)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: TColors.primary.withOpacity(0.8),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () => currentStep.value--,
                    child: const Text('Previous'),
                  ),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TColors.primary,
                    foregroundColor: Colors.white,
                  ),
                  onPressed:
                      currentStep.value < steps.length - 1
                          ? () => currentStep.value++
                          : null,
                  child: const Text('Next'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// Enhanced Step Indicator with better alignment
class StepIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final List<String> stepTitles;

  const StepIndicator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.stepTitles,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: TColors.primary.withOpacity(0.05),
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
      ),
      child: Column(
        children: [
          // Step indicators with connecting lines
          Row(
            children: List.generate(totalSteps * 2 - 1, (index) {
              if (index.isOdd) {
                // This is a connecting line
                final stepIndex = index ~/ 2;
                final isCompleted = stepIndex < currentStep;

                return Expanded(
                  child: Container(
                    height: 2,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: isCompleted ? TColors.primary : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                );
              } else {
                // This is a step circle
                final stepIndex = index ~/ 2;
                final isActive = stepIndex <= currentStep;
                final isCompleted = stepIndex < currentStep;

                return _buildStepCircle(stepIndex + 1, isActive, isCompleted);
              }
            }),
          ),

          const SizedBox(height: 16),

          // Step titles - perfectly aligned under circles
          Row(
            children: List.generate(totalSteps, (index) {
              final isActive = index <= currentStep;

              return Expanded(
                child: Text(
                  stepTitles[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                    color: isActive ? TColors.primary : Colors.grey.shade600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildStepCircle(int stepNumber, bool isActive, bool isCompleted) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive
            ? (isCompleted ? TColors.primary : Colors.white)
            : Colors.grey.shade200,
        border: Border.all(
          color: isActive ? TColors.primary : Colors.grey.shade400,
          width: 2,
        ),
      ),
      child: Center(
        child: isCompleted
            ? const Icon(Icons.check, size: 18, color: Colors.white)
            : Text(
          '$stepNumber',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isActive ? TColors.primary : Colors.grey.shade600,
          ),
        ),
      ),
    );
  }
}

// Updated LocationStep with proper form layout
class LocationStep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AnnouncementController>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Location Details',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: TColors.primary,
            ),
          ),
          const SizedBox(height: 24),

          // Inside LocationStep build method

          MiniMapSelector(),   // Select starting location (latitude)
                // Select destination (longitude)

          const SizedBox(height: 20),

          // State Dropdown
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'State (Wilaya)',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Obx(
                () => DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    hintText: 'Select state',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: TColors.primary,
                        width: 2,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  value:
                      controller.selectedState.value.isEmpty
                          ? null
                          : controller.selectedState.value,
                  items:
                      controller.states
                          .map(
                            (state) => DropdownMenuItem(
                              value: state,
                              child: Text(
                                state,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      controller.selectState(value);
                    }
                  },
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Please select a state'
                              : null,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // City Dropdown
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'City (Commune)',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Obx(
                () => DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    hintText: 'Select city',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: TColors.primary,
                        width: 2,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  value:
                      controller.selectedCity.value.isEmpty
                          ? null
                          : controller.selectedCity.value,
                  items:
                      controller.cities
                          .map(
                            (city) => DropdownMenuItem(
                              value: city,
                              child: Text(
                                city,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      controller.selectCity(value);
                    }
                  },
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Please select a city'
                              : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Complete page example
class CreateAnnouncementPage extends StatelessWidget {
  final List<String> stepTitles = ['Location', 'Schedule','Details' 'Review'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Announcement'),
        backgroundColor: TColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          StepIndicator(currentStep: 0, totalSteps: 4, stepTitles: stepTitles),
          Expanded(child: LocationStep()),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.grey.shade300, width: 1),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // Previous step logic
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: BorderSide(color: TColors.primary),
                    ),
                    child: const Text(
                      'Back',
                      style: TextStyle(
                        color: TColors.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Next step logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: TColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Step 2: Date and Time Details
class DetailsStep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AnnouncementController>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Date & Time Details',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: TColors.primary,
            ),
          ),
          const SizedBox(height: 16),
          Obx(
            () => ListTile(
              title: Text(
                controller.selectedStartDate.value == null
                    ? 'Select Start Date'
                    : 'Start Date: ${controller.selectedStartDate.value!.toString().substring(0, 10)}',
                style: TextStyle(
                  color:
                      controller.selectedStartDate.value == null
                          ? Colors.grey
                          : TColors.primary,
                ),
              ),
              trailing: const Icon(
                Icons.calendar_today,
                color: TColors.primary,
              ),
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: const ColorScheme.light(
                          primary: TColors.primary,
                          onPrimary: Colors.white,
                          onSurface: Colors.black,
                        ),
                      ),
                      child: child!,
                    );
                  },
                );
                if (date != null) controller.selectedStartDate.value = date;
              },
            ),
          ),
          const SizedBox(height: 16),
          Obx(
            () => ListTile(
              title: Text(
                controller.selectedStartTime.value == null
                    ? 'Select Start Time'
                    : 'Start Time: ${controller.selectedStartTime.value!.format(context)}',
                style: TextStyle(
                  color:
                      controller.selectedStartTime.value == null
                          ? Colors.grey
                          : TColors.primary,
                ),
              ),
              trailing: const Icon(Icons.access_time, color: TColors.primary),
              onTap: () async {
                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: const ColorScheme.light(
                          primary: TColors.primary,
                          onPrimary: Colors.white,
                          onSurface: Colors.black,
                        ),
                      ),
                      child: child!,
                    );
                  },
                );
                if (time != null) controller.selectedStartTime.value = time;
              },
            ),
          ),
          const SizedBox(height: 16),
          Obx(
            () => ListTile(
              title: Text(
                controller.selectedEndTime.value == null
                    ? 'Select End Time'
                    : 'End Time: ${controller.selectedEndTime.value!.format(context)}',
                style: TextStyle(
                  color:
                      controller.selectedEndTime.value == null
                          ? Colors.grey
                          : TColors.primary,
                ),
              ),
              trailing: const Icon(Icons.access_time, color: TColors.primary),
              onTap: () async {
                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: const ColorScheme.light(
                          primary: TColors.primary,
                          onPrimary: Colors.white,
                          onSurface: Colors.black,
                        ),
                      ),
                      child: child!,
                    );
                  },
                );
                if (time != null) controller.selectedEndTime.value = time;
              },
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: controller.descriptionController,
            maxLines: 4,
            decoration: InputDecoration(
              labelText: 'Additional Notes',
              border: const OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: TColors.primary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Step 3: Audience Information
class AudienceStep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AnnouncementController>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Target Audience',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: TColors.primary,
            ),
          ),
          const SizedBox(height: 16),
          Obx(
            () => DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Target Audience',
                border: const OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: TColors.primary),
                ),
              ),
              value:
                  controller.selectedTargetAudience.value.isEmpty
                      ? null
                      : controller.selectedTargetAudience.value,
              items:
                  ['All', 'Children', 'Elderly', 'Disabled']
                      .map(
                        (audience) => DropdownMenuItem(
                          value: audience,
                          child: Text(audience),
                        ),
                      )
                      .toList(),
              onChanged: (value) {
                if (value != null)
                  controller.selectedTargetAudience.value = value;
              },
              validator:
                  (value) =>
                      value == null || value.isEmpty
                          ? 'Please select a target audience'
                          : null,
            ),
          ),
          const SizedBox(height: 16),
          Obx(
            () => TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Minimum Age (Optional)',
                border: const OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: TColors.primary),
                ),
              ),
              onChanged: (value) {
                controller.minAge.value = int.tryParse(value) ?? 0;
              },
              controller: TextEditingController(
                text:
                    controller.minAge.value > 0
                        ? controller.minAge.value.toString()
                        : '',
              ),
            ),
          ),
          const SizedBox(height: 16),
          Obx(
            () => TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Maximum Age (Optional)',
                border: const OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: TColors.primary),
                ),
              ),
              onChanged: (value) {
                controller.maxAge.value = int.tryParse(value) ?? 100;
              },
              controller: TextEditingController(
                text:
                    controller.maxAge.value < 100
                        ? controller.maxAge.value.toString()
                        : '',
              ),
            ),
          ),
          const SizedBox(height: 16),
          Obx(
            () => CheckboxListTile(
              title: const Text('Active'),
              value: controller.isActive.value,
              onChanged: (value) {
                if (value != null) controller.isActive.value = value;
              },
              activeColor: TColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

// Step 4: Confirmation and Submission
class ConfirmationStep extends StatelessWidget {
  final Announcement? announcement;
  final bool isUpdating;

  const ConfirmationStep({
    super.key,
    required this.announcement,
    required this.isUpdating,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AnnouncementController>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Review & Submit',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: TColors.primary,
            ),
          ),
          const SizedBox(height: 16),
          Obx(
            () => Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'State: ${controller.selectedState.value}',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text('City: ${controller.selectedCity.value}'),
                    if (controller.startingPointController.text.isNotEmpty)
                      Text(
                        'Starting Point: ${controller.startingPointController.text}',
                      ),
                    if (controller.endingPointController.text.isNotEmpty)
                      Text(
                        'Ending Point: ${controller.endingPointController.text}',
                      ),
                    Text(
                      'Start Date: ${controller.selectedStartDate.value?.toString().substring(0, 10) ?? 'Not set'}',
                    ),
                    Text(
                      'Start Time: ${controller.selectedStartTime.value?.format(context) ?? 'Not set'}',
                    ),
                    Text(
                      'End Time: ${controller.selectedEndTime.value?.format(context) ?? 'Not set'}',
                    ),
                    Text(
                      'Target Audience: ${controller.selectedTargetAudience.value}',
                    ),
                    if (controller.minAge.value > 0)
                      Text('Minimum Age: ${controller.minAge.value}'),
                    if (controller.maxAge.value < 100)
                      Text('Maximum Age: ${controller.maxAge.value}'),
                    Text('Active: ${controller.isActive.value ? 'Yes' : 'No'}'),
                    if (controller.descriptionController.text.isNotEmpty)
                      Text('Notes: ${controller.descriptionController.text}'),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Obx(
            () => Center(
              child:
                  controller.isSubmitting.value
                      ? const CircularProgressIndicator(color: TColors.primary)
                      : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: TColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 12,
                          ),
                        ),
                        onPressed: () async {
                          if (controller.validateForm()) {
                            final newAnnouncement = Announcement(
                              uid: announcement?.uid ?? '',
                              publisherId: '',
                              state: controller.selectedState.value,
                              city: controller.selectedCity.value,
                              targetAudience:
                                  controller.selectedTargetAudience.value,
                              startDate: controller.selectedStartDate.value!,
                              startTime: controller.selectedStartTime.value!,
                              endTime: controller.selectedEndTime.value!,
                              startingPoint:
                                  controller.startingPointController.text
                                      .trim(),
                              endingPoint:
                                  controller.endingPointController.text.trim(),
                              additionalNotes:
                                  controller.descriptionController.text.trim(),
                              minAge:
                                  controller.minAge.value > 0
                                      ? controller.minAge.value
                                      : null,
                              maxAge:
                                  controller.maxAge.value < 100
                                      ? controller.maxAge.value
                                      : null,
                              isActive: controller.isActive.value,
                              status: announcement?.status ?? 'Pending',
                              views: announcement?.views ?? 0,
                              createdAt:
                                  announcement?.createdAt ??
                                  DateTime.now().toUtc(),
                              updatedAt: DateTime.now().toUtc(),
                            );

                            bool success;
                            if (isUpdating) {
                              success = await controller.updateAnnouncement(
                                newAnnouncement,
                              );
                            } else {
                              success = await controller.createAnnouncement(
                                newAnnouncement,
                              );
                            }

                            if (success) {
                              Get.back();
                            }
                          }
                        },
                        child: Text(isUpdating ? 'Update' : 'Submit'),
                      ),
            ),
          ),
        ],
      ),
    );
  }
}
