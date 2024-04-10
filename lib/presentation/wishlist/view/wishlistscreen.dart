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
      body: FutureBuilder<List<String>>(
        future: getWishlistFromStorage(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<String>? wishlistTitles = snapshot.data;
            return ListView.builder(
              itemCount: wishlistTitles?.length ?? 0,
              itemBuilder: (context, index) {
                String title = wishlistTitles![index];
                // Find Cart item from the wishlist using title
                Cart cart = Provider.of<Wishlist_ctrl>(context, listen: false)
                    .wishlist
                    .firstWhere((cart) => cart.title == title);
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
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      subtitle: Text(cart.description),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<String>> getWishlistFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('wishlist') ?? [];
  }
}
