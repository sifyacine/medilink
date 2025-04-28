import 'package:flutter/material.dart';

class PaymentAmountRow extends StatelessWidget {
  final String label;
  final double amount;
  final bool isBold;

  const PaymentAmountRow({
    Key? key,
    required this.label,
    required this.amount,
    this.isBold = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isBold
              ? theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)
              : theme.textTheme.bodyMedium,
        ),
        Text(
          '${amount.toStringAsFixed(2)} DA',
          style: isBold
              ? theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)
              : theme.textTheme.bodyMedium,
        ),
      ],
    );
  }
}
