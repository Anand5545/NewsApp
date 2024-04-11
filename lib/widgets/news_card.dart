import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasknews/presentation/Homescreen/controller/homescreencontroller.dart';
import 'package:tasknews/presentation/wishlist/controller/wishlist_ctrl.dart';

class NewsCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String description;

  const NewsCard({
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  bool outline = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: widget.imageUrl,
            placeholder: (context, url) =>
                Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) =>
                Center(child: Icon(Icons.error)),
          ),
          // Image.network(
          //   imageUrl,
          //   width: double.infinity,
          //   height: 200.0,
          //   fit: BoxFit.cover,
          // ),
          SizedBox(height: 10.0),
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            widget.description,
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 5.0),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    String newsToShare =
                        "${widget.title} \n \n ${widget.description} \n \n $Uri";
                    Provider.of<HomeScreenController>(context, listen: false)
                        .sharetext(textToShare: newsToShare);
                  },
                  icon: Icon(Icons.share)),
              // IconButton(
              //   onPressed: () {
              //     Provider.of<Wishlist_ctrl>(context, listen: false)
              //         .addToWishlist(
              //             widget.imageUrl, widget.title, widget.description);
              //   },
              //   icon: Icon(
              //     Icons.bookmark_outline,
              //     color: Provider.of<Wishlist_ctrl>(context)
              //             .wishlist
              //             .contains(widget.title)
              //         ? Colors.red
              //         : Colors.black,
              //   ),
              // )
              IconButton(
                onPressed: () {
                  setState(() {
                    outline = !outline;
                  });
                  if (outline) {
                    // Add to wishlist
                    Provider.of<Wishlist_ctrl>(context, listen: false)
                        .addToWishlist(
                            widget.imageUrl, widget.title, widget.description);
                  } else {
                    // Remove from wishlist
                    Provider.of<Wishlist_ctrl>(context, listen: false)
                        .removeFromWishlist(widget.title);
                  }
                },
                icon: Icon(
                  Icons.bookmark_outline,
                  color: outline ? Colors.red : Colors.black,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
