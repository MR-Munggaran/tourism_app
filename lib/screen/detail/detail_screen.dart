import 'dart:async';
import 'package:flutter/material.dart';
import 'package:projectpractice01/provider/bookmark_icon_provider.dart';
import 'package:projectpractice01/provider/detail/tourism_detail_provider.dart';
import 'package:projectpractice01/screen/detail/bookmark_icon_widget.dart';
import 'package:provider/provider.dart';
import '../../static/tourism_detail_result_state.dart';

class DetailScreen extends StatefulWidget {
  final int tourismId;

  const DetailScreen({super.key, required this.tourismId});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  double _baseScaleFactor = 0.5;
  double _scaleFactor = 1.0;

  @override
  void initState() {
    super.initState();
    // Memanggil fetchTourismDetail dari provider
    Future.microtask(() {
      context.read<TourismDetailProvider>().fetchTourismDetail(widget.tourismId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tourism Detail'),
        actions: [
          ChangeNotifierProvider(
            create: (context) => BookmarkIconProvider(),
            child: Consumer<TourismDetailProvider>(
              builder: (context, provider, child) {
                return switch (provider.resultState) {
                  TourismDetailLoadedState(data: var tourism) =>
                      BookmarkIconWidget(tourism: tourism),
                  _ => const SizedBox(),
                };
              },
            ),
          ),
        ],
      ),
      body: Consumer<TourismDetailProvider>(
        builder: (context, provider, child) {
          return switch (provider.resultState) {
            TourismDetailLoadingState() => const Center(
              child: CircularProgressIndicator(),
            ),
            TourismDetailLoadedState(data: var tourism) => SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onScaleStart: (details) =>
                          setState(() => _scaleFactor = _baseScaleFactor),
                      onScaleUpdate: (details) => setState(() {
                        _baseScaleFactor = _scaleFactor * details.scale;
                      }),
                      onScaleEnd: (details) =>
                          setState(() => _baseScaleFactor = 1.0),
                      child: Transform.scale(
                        scale: _baseScaleFactor,
                        child: Image.network(
                          tourism.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tourism.name,
                                style: Theme.of(context).textTheme.headlineLarge,
                              ),
                              Text(
                                tourism.address,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.favorite),
                            const SizedBox(width: 4),
                            Text(
                              tourism.like.toString(),
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      tourism.description,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
            TourismDetailErrorState(error: var message) => Center(
              child: Text(message),
            ),
            _ => const SizedBox(),
          };
        },
      ),
    );
  }
}