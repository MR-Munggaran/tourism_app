import 'package:flutter/material.dart';
import 'package:projectpractice01/model/tourism.dart';
import 'package:projectpractice01/screen/home/tourism_card_widget.dart';
import 'package:projectpractice01/static/navigation_route.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tourism List"),
      ),
      body: ListView.builder(
        itemCount: tourismList.length,
        itemBuilder: (context, index) {
          final tourism = tourismList[index];

          return TourismCard(
            tourism: tourism,
            onTap: () => {
              Navigator.pushNamed(context, NavigationRoute.detailRoute.name,
                  arguments: tourism)
            },
          );
        },
      ),
    );
  }
}
