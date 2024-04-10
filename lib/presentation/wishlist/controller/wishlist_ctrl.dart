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
        'wishlist', wishlist.map((cart) => cart.title).toList());

    notifyListeners();
  }
}
