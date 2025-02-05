import "package:flutter/material.dart";
import 'package:projectpractice01/data/model/tourism.dart';

import "package:projectpractice01/provider/bookmark_list_provider.dart";
import "package:projectpractice01/provider/bookmark_icon_provider.dart";
import "package:provider/provider.dart";

class BookmarkIconWidget extends StatefulWidget {
  final Tourism tourism;

  const BookmarkIconWidget({super.key, required this.tourism});

  @override
  State<BookmarkIconWidget> createState() => _BookmarkIconWidgetState();
}

class _BookmarkIconWidgetState extends State<BookmarkIconWidget> {
  @override
  void initState() {
    final bookmarkListProvider = context.read<BookmarkListProvider>();
    final bookmarkIconProvider = context.read<BookmarkIconProvider>();

    Future.microtask(() {
      final tourismInList =
          bookmarkListProvider.checkItemBookmark(widget.tourism);
      bookmarkIconProvider.isBookmarked = tourismInList;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          final bookmarkListProvider = context.read<BookmarkListProvider>();
          final bookmarkIconProvider = context.read<BookmarkIconProvider>();
          final isBookmarked = bookmarkIconProvider.isBookmarked;

          if (!isBookmarked) {
            bookmarkListProvider.addBookmark(widget.tourism);
          } else {
            bookmarkListProvider.removeBookmark(widget.tourism);
          }
          bookmarkIconProvider.isBookmarked = !isBookmarked;
        },
        icon: Icon(context.watch<BookmarkIconProvider>().isBookmarked
            ? Icons.bookmark
            : Icons.bookmark_outline));
  }
}
