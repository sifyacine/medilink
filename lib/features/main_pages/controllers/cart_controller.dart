import 'package:get/get.dart';

import '../../../data/dummy_data.dart';
import '../models/medicine_model.dart';

class CartController extends GetxController {
  var cartItems = <Product>[

  ].obs;
  final RxList<Product> products = dummyProduct.obs;

  void addToCart(Product product) {
    cartItems.add(product);
  }

  void removeFromCart(Product product) {
    cartItems.remove(product);
  }

  void clearCart() {
    cartItems.clear();
  }

  double get totalPrice => cartItems.fold(0, (sum, item) => sum + item.price);
  List<Product> get allProducts => products;

}
