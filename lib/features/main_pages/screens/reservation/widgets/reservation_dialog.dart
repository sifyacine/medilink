import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../../authentication/models/nurse_model.dart';
import '../../../../personalization/controllers/user_controller.dart';
import '../../../models/announcment_model.dart';

class ReservationDialog extends StatefulWidget {
  final Announcement announcement;
  final Function(double, String) onReserve;

  const ReservationDialog({
    super.key,
    required this.announcement,
    required this.onReserve,
  });

  @override
  State<ReservationDialog> createState() => _ReservationDialogState();
}

class _ReservationDialogState extends State<ReservationDialog> {
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final UserController _userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    // Get the current nurse data - THIS WILL NOW SHOW ACTUAL DATA
    final currentNurse = _userController.currentNurseForReservation;

    return Dialog(
      backgroundColor: isDark ? TColors.dark : TColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Send Reservation Request',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Iconsax.close_circle),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Nurse Info - NOW SHOWS ACTUAL USER DATA
              _buildInfoSection(context, 'Your Information', [
                _buildInfoRow('Name', _userController.currentUserName ),
                _buildInfoRow('Phone', _userController.currentUserPhone),
                _buildInfoRow('Email', _userController.currentUserEmail),
                if (currentNurse?.specialization != null && currentNurse!.specialization!.isNotEmpty)
                  _buildInfoRow('Specialization', currentNurse.specialization!),
              ]),

              const SizedBox(height: 24),

              // Price Input
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Proposed Price (\$)',
                  prefixIcon: const Icon(Iconsax.dollar_circle),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Additional Notes
              TextFormField(
                controller: _notesController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Additional Notes (Optional)',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: Get.back,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(color: TColors.primary),
                      ),
                      child: Text(
                        'Cancel',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: TColors.primary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _submitReservation,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: TColors.primary,
                        foregroundColor: TColors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Send Request'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: THelperFunctions.isDarkMode(context)
                ? TColors.darkerGrey
                : TColors.light,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(value),
          ),
        ],
      ),
    );
  }

  void _submitReservation() {
    if (_formKey.currentState!.validate()) {
      final price = double.parse(_priceController.text);
      final notes = _notesController.text;
      widget.onReserve(price, notes);
    }
  }
}