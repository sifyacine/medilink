import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink/utils/helpers/helper_functions.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../controllers/appointment_controller.dart';

class PaymentMethodSection extends StatelessWidget {
  final AppointmentController controller;

  const PaymentMethodSection({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = THelperFunctions.isDarkMode(context);
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Payment method info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mode de paiement',
                  style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark? TColors.dark : TColors.light,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.credit_card, size: 24, color: TColors.primary),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          controller.paymentMethod.value,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // "Modifier" button
          InkWell(
            onTap: controller.editPaymentMethod,
            child: const Text(
              'update',
              style: TextStyle(
                color: TColors.primary,
              ),
            ),
          ),
        ],
      );
    });
  }
}
