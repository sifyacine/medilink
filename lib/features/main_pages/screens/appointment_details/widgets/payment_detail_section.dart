import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink/features/main_pages/screens/appointment_details/widgets/payment_amount_row.dart';
import 'package:medilink/utils/constants/colors.dart';
import 'package:medilink/utils/helpers/helper_functions.dart';

import '../../../controllers/appointment_controller.dart';


class PaymentDetailSection extends StatelessWidget {
  final AppointmentController controller;

  const PaymentDetailSection({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = THelperFunctions.isDarkMode(context);
    return Obx(() {
      // Calculate total inside Obx for reactive update
      final total = controller.consultationFee.value +
          controller.adminFee.value -
          controller.additionalDiscount.value;
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark? TColors.dark : TColors.light,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment Detail',
              style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            PaymentAmountRow(
              label: 'Consultation',
              amount: controller.consultationFee.value,
            ),
            PaymentAmountRow(
              label: 'Frais administratifs',
              amount: controller.adminFee.value,
            ),
            PaymentAmountRow(
              label: 'Réduction supplémentaire',
              amount: controller.additionalDiscount.value,
            ),
            const SizedBox(height: 8),
            Divider(color: Colors.grey[400]),
            const SizedBox(height: 8),
            PaymentAmountRow(
              label: 'Total',
              amount: total,
              isBold: true,
            ),
          ],
        ),
      );
    });
  }
}
