import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:tasknews/repository/api/category.dart';
import 'package:http/http.dart' as http;

class CategoryController extends ChangeNotifier {
  List<String> categoryList = [
    "Business",
    "Entertainment",
    "General",
    "Health",
    "Screen",
    "Sports",
    "Technology"
  ];

  String category = "business";

  onTap({required int index}) {
    category = categoryList[index].toLowerCase();
    fetchdata();
    print(category);
    notifyListeners();
  }

  Categorymodel? newsModel;
  bool isloading = false;

  void fetchdata() async {
    isloading = true;
    notifyListeners();
    print("a");
    final url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=040c8cbf72524a3da72b8d7f0ce35e46");
    print("b");
    try {
      final response = await http.get(url);
      print(response.statusCode);
      print("c");
      Map<String, dynamic> decodedData = {};
      if (response.statusCode == 200) {
        decodedData = jsonDecode(response.body);
        print(decodedData);
      } else {
        print("Api Failed");
      }
      newsModel = Categorymodel.fromJson(decodedData);
    } catch (e) {
      print("error fetch data: $e");
      notifyListeners();
    }
    isloading = false;
    notifyListeners();
  }
}
