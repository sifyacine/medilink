// lib/features/main_pages/models/cart_item.dart (or wherever you put your models)
import 'package:medilink/features/main_pages/models/medicine_model.dart'; // Adjust path if needed

class CartItem {
  final Product product;
  int quantity; // Make quantity mutable as it can change in the cart

  CartItem({required this.product, required this.quantity});

  // Optional: Getter for total price of this item line
  int get lineTotal => product.reductionPercentage * quantity; // Use discounted price

  // Optional: Override equality check if needed (e.g., based on product id)
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CartItem && runtimeType == other.runtimeType && product.id == other.product.id; // Assuming Product has an 'id'

  @override
  int get hashCode => product.id.hashCode; // Assuming Product has an 'id'
}