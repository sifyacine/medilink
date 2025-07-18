
// lib/features/main_pages/controllers/wishlist_controller.dart
import 'package:get/get.dart';
import '../models/medicine_model.dart';

class WishlistController extends GetxController {
  final RxList<Product> wishlist = <Product>[].obs;

  void addToWishlist(Product product) {
    if (!wishlist.contains(product)) {
      wishlist.add(product);
    }
  }

  void removeFromWishlist(Product product) {
    wishlist.remove(product);
  }

  bool isInWishlist(Product product) => wishlist.contains(product);
}
