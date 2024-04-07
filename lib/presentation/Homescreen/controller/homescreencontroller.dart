import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tasknews/repository/api/topheadlines.dart';
import 'package:http/http.dart' as http;

class HomeScreenController with ChangeNotifier {
  Newsmodel? newsModel;
  bool isloading = false;

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
}
