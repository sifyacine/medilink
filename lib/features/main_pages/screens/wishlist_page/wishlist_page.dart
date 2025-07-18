import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/wishlist_controller.dart';

// -----------------------------
// WishlistScreen
// -----------------------------
class WishlistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wishlistCtrl = Get.put(WishlistController());

    return Scaffold(
      appBar: AppBar(title: Text('My Wishlist')),
      body: Obx(() {
        if (wishlistCtrl.wishlist.isEmpty) {
          return Center(child: Text('No items in wishlist'));
        }
        return ListView.builder(
          itemCount: wishlistCtrl.wishlist.length,
          itemBuilder: (context, index) {
            final product = wishlistCtrl.wishlist[index];
            return ListTile(
              leading: Image.asset(product.imageUrl, width: 50, height: 50),
              title: Text(product.name),
              subtitle: Text('\$${product.price} DA'),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => wishlistCtrl.removeFromWishlist(product),
              ),
            );
          },
        );
      }),
    );
  }
}