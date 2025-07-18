// lib/features/cart/widgets/t_cart_items.dart

import 'package:flutter/material.dart';
import '../../../../../common/widgets/products/cart/add_remove_button.dart';
import '../../../../../common/widgets/products/cart/cart_item.dart';
import '../../../../../common/widgets/texts/produt_price_text.dart';
import '../../../../../data/dummy_data.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../models/medicine_model.dart';


/// Displays a scrollable list of cart items using in‑memory dummy data.
class TCartItems extends StatelessWidget {
  const TCartItems({Key? key, this.showAddRemoveButtons = true}) : super(key: key);

  /// If false, hides the +/– buttons and price beneath each item.
  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    // Simply use the static dummyProduct list
    final List<Product> medicines = dummyProduct;

    return ListView.separated(
      shrinkWrap: true,
      itemCount: medicines.length,
      separatorBuilder: (_, __) => const SizedBox(height: TSizes.spaceBtwSections),
      itemBuilder: (context, index) {
        final med = medicines[index];
        return Column(
          children: [
            TCartItem(
              productTitle: med.name,
              pharmacyName: med.manufacturer.toString(),
              productImage: med.imageUrl,
              productDosage: med.size,
            ),
            if (showAddRemoveButtons) const SizedBox(height: TSizes.spaceBtwItems),
            if (showAddRemoveButtons)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 70),
                  const TProductQuantityWithAddRemoveButton(),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: TProductPriceText(
                      price: med.price.toStringAsFixed(2),
                    ),
                  ),
                ],
              ),
          ],
        );
      },
    );
  }
}
