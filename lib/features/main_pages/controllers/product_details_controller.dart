import 'package:get/get.dart';
import '../models/medicine_model.dart'; // Make sure this path is correct
// Assuming your RatingModel looks something like this:
// class RatingModel {
//   final double rating;
//   // other fields like review, reviewerId etc.
//   RatingModel({required this.rating});
// }


class ProductDetailsController extends GetxController {
  final Product product;

  // Observables
  final RxInt quantity = 1.obs;
  final RxDouble averageRating = 0.0.obs; // <-- Added for rating
  final RxInt ratingCount = 0.obs;       // <-- Added for rating count

  ProductDetailsController(this.product);

  @override
  void onInit() {
    super.onInit();
    // Initialize quantity based on stock
    if (product.stock <= 0) {
      quantity.value = 0;
    } else {
      quantity.value = 1; // Start with 1 if in stock
    }

    // Calculate initial rating
    _calculateAverageRating();
  }

  // --- Rating Calculation ---
  void _calculateAverageRating() {
    // Ensure product.ratings is not null and is the correct list type
    // Replace 'product.ratings' if your actual field name is different
    // Replace 'r.rating' if your RatingModel uses a different field name
    if (product.ratings != null && product.ratings.isNotEmpty) {
      // Assuming product.ratings is List<RatingModel>
      // and RatingModel has a 'double rating' field
      averageRating.value = product.ratings
          .map((r) => r.rating) // This accesses the 'rating' field from your Review model
          .reduce((a, b) => a + b) /
          product.ratings.length;
      ratingCount.value = product.ratings.length;
    } else {
      averageRating.value = 0.0;
      ratingCount.value = 0;
    }
  }

  // --- Computed Properties ---
  double get originalPrice => product.price;
  int get discount => product.reductionPercentage;
  // This calculation is fine as it depends on static product data
  double get discountedPrice => originalPrice * (1 - (discount / 100.0));
  // Optional: A getter for the final price considering quantity
  double get totalPrice => discountedPrice * quantity.value;
  // Stock left calculation remains valid
  int get stockLeft => product.stock - quantity.value;


  // --- Actions ---
  void incrementQuantity() {
    // Allow increment only if current quantity is less than stock
    if (quantity.value < product.stock) {
      quantity.value++;
    }
  }

  void decrementQuantity() {
    // Allow decrement only if quantity is greater than 1
    // Or set to 0 if you allow that and handle it elsewhere?
    // Current logic prevents going below 1.
    if (quantity.value > 1) {
      quantity.value--;
    }
  }
}