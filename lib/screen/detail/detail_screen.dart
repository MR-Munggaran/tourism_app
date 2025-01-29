import 'package:flutter/material.dart';
import 'package:projectpractice01/model/tourism.dart';

class DetailScreen extends StatefulWidget {
  final Tourism tourism;

  const DetailScreen({super.key, required this.tourism});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  double _baseScaleFactor = 0.5;
  double _scaleFactor = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tourism Detail'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              GestureDetector(
                  onScaleStart: (details) => {_scaleFactor = _baseScaleFactor},
                  onScaleUpdate: (details) => {
                        setState(() {
                          _baseScaleFactor = _scaleFactor * details.scale;
                        })
                      },
                  onScaleEnd: (details) => _baseScaleFactor = 1.0,
                  child: Transform.scale(
                      scale: _baseScaleFactor,
                      child: Image.network(widget.tourism.image,
                          fit: BoxFit.cover))),
              const SizedBox.square(dimension: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.tourism.name,
                          style: Theme.of(context).textTheme.headlineLarge),
                      Text(
                        widget.tourism.address,
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(fontWeight: FontWeight.w400),
                      )
                    ],
                  )),
                  Row(
                    children: [
                      const Icon(Icons.favorite),
                      const SizedBox.square(
                        dimension: 4,
                      ),
                      Text(
                        widget.tourism.like.toString(),
                        style: Theme.of(context).textTheme.bodyLarge,
                      )
                    ],
                  )
                ],
              ),
              const SizedBox.square(
                dimension: 16,
              ),
              Text(
                widget.tourism.description,
                style: Theme.of(context).textTheme.bodyLarge,
              )
            ],
          ),
        ),
      ),
    );
  }
}
