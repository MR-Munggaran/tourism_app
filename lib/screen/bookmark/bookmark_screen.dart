import 'package:flutter/material.dart';
import 'package:projectpractice01/screen/home/tourism_card_widget.dart';
import 'package:projectpractice01/static/navigation_route.dart';
import "../../model/tourism.dart";

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bookmark List"),
      ),
      body: ListView.builder(
        itemCount: bookmarkTourismList.length,
        itemBuilder: (context, index) {
          final tourism = bookmarkTourismList[index];

          return  TourismCard(tourism: tourism, onTap: () => {
            Navigator.pushNamed(context, NavigationRoute.detailRoute.name, arguments: tourism)
          },);
        },
      ),
    );
  }
}