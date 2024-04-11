import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasknews/presentation/wishlist/controller/wishlist_ctrl.dart';
import 'package:tasknews/repository/api/cart.dart';

class WishlistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wishlistt"),
      ),
      body: Center(
        child: FutureBuilder<List<String>>(
          future: getWishlistFromStorage(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              List<String>? wishlistTitles = snapshot.data;

              // Check if the wishlist is empty
              if (wishlistTitles == null || wishlistTitles.isEmpty) {
                return Center(
                  child: Text('Cart is empty'),
                );
              } else {
                return ListView.builder(
                  itemCount: wishlistTitles.length,
                  itemBuilder: (context, index) {
                    String title = wishlistTitles[index];

                    // Find Cart item from the wishlist using title
                    var cartList =
                        Provider.of<Wishlist_ctrl>(context, listen: false)
                            .wishlist;

                    // Check if the cart list is empty
                    if (cartList.isEmpty) {
                      return Center(
                        child: Text('Cart is empty'),
                      );
                    }

                    // Find the cart item with matching title
                    Cart? cart;
                    for (var cartItem in cartList) {
                      if (cartItem.title == title) {
                        cart = cartItem;
                        break;
                      }
                    }

                    // Check if the cart item is found
                    if (cart == null) {
                      return Center(
                        child: Text('Cart item not found for $title'),
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey.shade100,
                        ),
                        child: ListTile(
                          leading: Image.network(cart.imageurl),
                          title: Text(
                            cart.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          subtitle: Text(cart.description),
                        ),
                      ),
                    );
                  },
                );
              }
            }
          },
        ),
      ),
    );
  }

  Future<List<String>> getWishlistFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('wishlist') ?? [];
  }
}
