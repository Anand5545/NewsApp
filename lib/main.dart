import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasknews/presentation/Category/controller/category_controller.dart';
import 'package:tasknews/presentation/Homescreen/controller/homescreencontroller.dart';
import 'package:tasknews/presentation/splashscreen/view/splash.dart';
import 'package:tasknews/presentation/wishlist/controller/wishlist_ctrl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeScreenController>(
          create: (context) => HomeScreenController(),
        ),
        ChangeNotifierProvider<CategoryController>(
          create: (context) => CategoryController(),
        ),
        ChangeNotifierProvider<Wishlist_ctrl>(
            create: (context) => Wishlist_ctrl())
      ],
      child: MaterialApp(
        home: Splash(),
      ),
    );
  }
}
