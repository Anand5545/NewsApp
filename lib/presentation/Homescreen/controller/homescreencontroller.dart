import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tasknews/repository/api/cart.dart';
import 'package:tasknews/repository/api/topheadlines.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class HomeScreenController with ChangeNotifier {
  Newsmodel? newsModel;
  bool isloading = false;
  var baseUrl = "https://newsapi.org/";

  void fetchdata() async {
    isloading = true;
    notifyListeners();
    print("a");
    final url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=040c8cbf72524a3da72b8d7f0ce35e46");
    print("b");
    try {
      final response = await http.get(url);
      print(response.statusCode);
      print("c");
      Map<String, dynamic> decodedData = {};
      if (response.statusCode == 200) {
        decodedData = jsonDecode(response.body);
      } else {
        print("Api Failed");
      }
      newsModel = Newsmodel.fromJson(decodedData);
    } catch (e) {
      print("error fetch data: $e");
      notifyListeners();
    }
    isloading = false;
    notifyListeners();
  }

  void sharetext({String textToShare = ""}) {
    try {
      Share.share(textToShare);
    } catch (e) {
      print("Error Sharing: $e");
    }
  }

  List<Cart> wishlist = [];

  void addToWishlist(String imageUrl, String title, String description) {
    wishlist
        .add(Cart(imageurl: imageUrl, title: title, description: description));
    notifyListeners();
  }

  Future<void> launchURL(String url) async {
    final Uri url1 = Uri.parse(url);
    try {
      if (!await launchUrl(url1, mode: LaunchMode.inAppWebView)) {
        await launchUrl(url1, mode: LaunchMode.inAppWebView);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching URL: $e');
    }
    notifyListeners();
  }
}
