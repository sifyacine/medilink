import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/nurse_announcement_controller.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NurseAnnouncementController());

    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filters',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              IconButton(
                onPressed: Get.back,
                icon: const Icon(Iconsax.close_circle),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // City Filter
          _buildFilterField(
            context,
            'City',
            controller.selectedCity.value,
                (value) => controller.selectedCity.value = value,
          ),

          const SizedBox(height: 16),

          // State Filter
          _buildFilterField(
            context,
            'State',
            controller.selectedState.value,
                (value) => controller.selectedState.value = value,
          ),

          const SizedBox(height: 16),

          // Audience Filter
          _buildDropdownFilter(
            context,
            'Target Audience',
            controller.selectedAudience.value,
            ['Children', 'Elderly', 'Disabled', 'All'],
                (value) => controller.selectedAudience.value = value ?? '',
          ),

          const SizedBox(height: 32),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: controller.clearFilters,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: BorderSide(color: TColors.primary),
                  ),
                  child: Text(
                    'Clear All',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: TColors.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    controller.searchAnnouncements();
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TColors.primary,
                    foregroundColor: TColors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    'Apply Filters',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: TColors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterField(
      BuildContext context,
      String label,
      String value,
      Function(String) onChanged,
      ) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        TextField(
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: 'Enter $label',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: TColors.grey),
            ),
            filled: true,
            fillColor: isDark ? TColors.dark : TColors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownFilter(
      BuildContext context,
      String label,
      String value,
      List<String> options,
      Function(String?) onChanged,
      ) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: TColors.grey),
            borderRadius: BorderRadius.circular(12),
            color: isDark ? TColors.dark : TColors.white,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value.isEmpty ? null : value,
              isExpanded: true,
              hint: Text('Select $label'),
              items: options.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}