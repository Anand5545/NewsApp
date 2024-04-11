import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasknews/repository/api/cart.dart';

class Wishlist_ctrl extends ChangeNotifier {
  List<Cart> wishlist = [];

  void addToWishlist(String imageUrl, String title, String description) async {
    wishlist
        .add(Cart(imageurl: imageUrl, title: title, description: description));

    // Save wishlist to storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
        'wishlist', wishlist.map((cart) => cart.title).toSet().toList());

    notifyListeners();
  }

  void removeFromWishlist(String title) {
    // Remove the card from the wishlist based on its title
    wishlist.removeWhere((cart) => cart.title == title);
    // Notify listeners that the state has changed
    notifyListeners();
  }
}
