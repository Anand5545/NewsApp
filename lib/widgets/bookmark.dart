import 'package:flutter/material.dart';

class BookmarkButton extends StatefulWidget {
  final VoidCallback onPressed;
  final bool isBookmarked;

  const BookmarkButton({
    required this.onPressed,
    this.isBookmarked = false,
    Key? key,
  }) : super(key: key);

  @override
  _BookmarkButtonState createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends State<BookmarkButton> {
  bool _isBookmarked = false;

  @override
  void initState() {
    super.initState();
    _isBookmarked = widget.isBookmarked;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          _isBookmarked = !_isBookmarked;
        });
        widget.onPressed();
      },
      icon: Icon(
        Icons.bookmark_outline,
        color: _isBookmarked ? Colors.pink : null,
      ),
    );
  }
}
