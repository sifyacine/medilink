import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/products/cart/add_remove_button.dart';
import '../../../../../common/widgets/products/cart/cart_item.dart';
import '../../../../../common/widgets/texts/produt_price_text.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/medicine_controller.dart';

class TCartItems extends StatelessWidget {
  const TCartItems({Key? key, this.showAddRemoveButtons = true}) : super(key: key);
  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    // Instantiate the controller (or use Get.find if already initialized)
    final MedicinesController medicinesController = Get.put(MedicinesController());

    return FutureBuilder<List<dynamic>>(
      future: medicinesController.loadMedicines(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text("Error loading medicines: ${snapshot.error}"));
        }
        final medicines = snapshot.data ?? [];
        return ListView.separated(
          shrinkWrap: true,
          itemBuilder: (_, index) {
            final medicine = medicines[index];
            return Column(
              children: [
                TCartItem(
                  productTitle: medicine['medicine_name'] ?? '',
                  pharmacyName: medicine['manufacturer'] ?? '',
                  productImage: medicine['medicine_pic'] ?? '',
                  productDosage: medicine['dosage'] ?? '',

                ),
                if (showAddRemoveButtons) const SizedBox(height: TSizes.spaceBtwItems),
                if (showAddRemoveButtons)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          SizedBox(width: 70),
                          TProductQuantityWithAddRemoveButton(),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: TProductPriceText(
                          price: (medicine['medicine_price'] != null)
                              ? medicine['medicine_price'].toString()
                              : '',
                        ),
                      ),
                    ],
                  ),
              ],
            );
          },
          separatorBuilder: (_, __) => const SizedBox(height: TSizes.spaceBtwSections),
          itemCount: medicines.length,
        );
      },
    );
  }
}
