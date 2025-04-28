import 'package:get/get.dart';

import '../models/medicine_model.dart';

class CartController extends GetxController {
  var cartItems = <Medicine>[].obs;

  void addToCart(Medicine medicine) {
    cartItems.add(medicine);
  }

  void removeFromCart(Medicine medicine) {
    cartItems.remove(medicine);
  }

  void clearCart() {
    cartItems.clear();
  }

  double get totalPrice => cartItems.fold(0, (sum, item) => sum + item.medicinePrice);
}
