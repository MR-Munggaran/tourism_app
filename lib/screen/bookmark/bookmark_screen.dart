import 'package:flutter/material.dart';
import 'package:projectpractice01/provider/bookmark/local_database_provider.dart';
import 'package:projectpractice01/screen/home/tourism_card_widget.dart';
import 'package:projectpractice01/static/navigation_route.dart';
import 'package:provider/provider.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<LocalDatabaseProvider>().loadAllTourismValue();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bookmark List"),
      ),
      // todo-03-action-01: change this provider to LocalDatabaseProvider
      body: Consumer<LocalDatabaseProvider>(
        builder: (context, value, child) {
          final bookmarkList = value.tourismList ?? [];
          return switch (bookmarkList.isNotEmpty) {
            true => ListView.builder(
                itemCount: bookmarkList.length,
                itemBuilder: (context, index) {
                  final tourism = bookmarkList[index];

                  return TourismCard(
                    tourism: tourism,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        NavigationRoute.detailRoute.name,
                        arguments: tourism.id,
                      );
                    },
                  );
                },
              ),
            _ => const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("No Bookmarked"),
                  ],
                ),
              ),
          };
        },
      ),
    );
  }
}
