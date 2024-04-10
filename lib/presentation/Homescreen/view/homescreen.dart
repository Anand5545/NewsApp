import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasknews/presentation/Category/controller/category_controller.dart';
import 'package:tasknews/presentation/Homescreen/controller/homescreencontroller.dart';
import 'package:tasknews/presentation/wishlist/view/wishlistscreen.dart';
import 'package:tasknews/widgets/news_card.dart';

class NewsApp extends StatefulWidget {
  @override
  State<NewsApp> createState() => _NewsAppState();
}

class _NewsAppState extends State<NewsApp> {
  @override
  void initState() {
    super.initState();
    fetchdata();
  }

  Widget build(BuildContext context) {
    HomeScreenController provider = Provider.of<HomeScreenController>(context);
    CategoryController categoryController =
        Provider.of<CategoryController>(context);
    return DefaultTabController(
      length: categoryController.categoryList.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "News app",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.green,
          bottom: TabBar(
            labelStyle: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600),
            labelColor: Colors.white,
            unselectedLabelColor: Color.fromARGB(255, 0, 0, 0),
            indicatorPadding: const EdgeInsets.symmetric(horizontal: 5),
            unselectedLabelStyle: const TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 15,
                fontWeight: FontWeight.w500),
            overlayColor: const MaterialStatePropertyAll(Colors.grey),
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
                color: Color.fromARGB(255, 31, 30, 30),
                borderRadius: BorderRadius.circular(10)),
            isScrollable: true,
            tabs: List.generate(
              categoryController.categoryList.length,
              (index) => Tab(
                text: categoryController.categoryList[index],
              ),
            ),
            onTap: (value) {
              categoryController.onTap(index: value);
            },
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WishlistScreen()),
                );
              },
              icon: Stack(children: [
                Icon(Icons.card_travel_sharp),
                if (provider.wishlist.isNotEmpty)
                  Positioned(
                    right: 0,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.red,
                      child: Text(
                        provider.wishlist.length.toString(),
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
              ]),
            ),
          ],
        ),
        body: ListView.builder(
            itemCount: categoryController.newsModel?.articles?.length,
            itemBuilder: (context, index) {
              return NewsCard(
                  imageUrl: categoryController
                          .newsModel?.articles?[index].urlToImage
                          .toString() ??
                      "",
                  title: categoryController.newsModel?.articles?[index].title
                          .toString() ??
                      "",
                  description: categoryController
                          .newsModel?.articles?[index].description
                          .toString() ??
                      "");
            }),
      ),
    );
  }

  void fetchdata() {
    Provider.of<CategoryController>(context, listen: false).fetchdata();
  }
}
