import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink/features/main_pages/screens/cart/widget/cart_item.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Cart',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: TCartItems(),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              builder: (BuildContext context) {
                return const CheckoutBottomSheet();
              },
            );
          },
          child: const Text('Checkout DZD 2254'),
        ),
      ),
    );
  }
}
class CheckoutBottomSheet extends StatelessWidget {
  const CheckoutBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    const double subtotal = 900.0;
    const double shipping = 50.0;
    const double total = subtotal + shipping;
    final isDark = THelperFunctions.isDarkMode(context);

    return SingleChildScrollView(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        decoration: BoxDecoration(
          color: isDark ? TColors.dark : TColors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text('Checkout',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: isDark ? TColors.white : TColors.dark,
                )),
            const SizedBox(height: TSizes.defaultSpace),

            // Price Details
            PriceDetailRow(label: 'Subtotal', value: '$subtotal DA'),
            PriceDetailRow(label: 'Shipping', value: '$shipping DA'),
            PriceDetailRow(label: 'Tax', value: '0 DA'),

            Divider(color: isDark ? TColors.darkGrey : TColors.grey),
            const SizedBox(height: TSizes.defaultSpace),

            // Total
            PriceDetailRow(
              label: 'Total',
              value: '$total DA',
              isBold: true,
            ),
            const SizedBox(height: TSizes.defaultSpace * 2),

            // Payment Method
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Payment Method',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: isDark ? TColors.white : TColors.dark,
                    )),
                const SizedBox(height: TSizes.defaultSpace / 2),
                PaymentMethodCard(),
              ],
            ),
            const SizedBox(height: TSizes.defaultSpace * 2),

            // Confirm Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: TColors.primary,
                  foregroundColor: TColors.white,
                ),
                child: const Text('Confirm Payment'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PriceDetailRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;

  const PriceDetailRow({
    super.key,
    required this.label,
    required this.value,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: TSizes.defaultSpace / 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                  color: isDark ? TColors.white : TColors.dark)),
          Text(value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                  color: isDark ? TColors.white : TColors.dark)),
        ],
      ),
    );
  }
}

class PaymentMethodCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Container(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      decoration: BoxDecoration(
        color: isDark ? TColors.darkerGrey : TColors.light,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isDark ? TColors.darkGrey : TColors.grey),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 30,
            decoration: BoxDecoration(
                color: TColors.primary,
                borderRadius: BorderRadius.circular(4)),
            child: const Icon(Icons.credit_card, color: TColors.white),
          ),
          const SizedBox(width: TSizes.defaultSpace),
          Expanded(
            child: Text('Visa **** 1234',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isDark ? TColors.white : TColors.dark,
                )),
          ),
          TextButton(
            onPressed: () {},
            child: Text('Change',
                style: TextStyle(color: TColors.primary)),
          ),
        ],
      ),
    );
  }
}
