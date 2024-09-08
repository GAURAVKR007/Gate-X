import 'dart:ui';

import 'package:cube_transition_plus/cube_transition_plus.dart';
import 'package:flutter/material.dart';

class Place {
  final String name;
  final String url;

  Place({required this.name, required this.url});
}

class HomePageCubeWidget extends StatelessWidget {
  // final List<Map<String, String>> data;
  // final int index;
  const HomePageCubeWidget({
    super.key,
    // required this.data,
    // required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final List<Place> places = [
      Place(name: 'My Content 1', url: "assets/icons/cube-pic-1.jpg"),
      Place(name: 'My Content 2', url: 'assets/icons/cube-pic-2.jpg'),
      Place(name: 'My Content 3', url: 'assets/icons/cube-pic-3.jpg'),
      Place(name: 'Read All Formulas', url: 'assets/icons/cube-pic-4.jpg'),
    ];
    final screenHeight = MediaQuery.of(context).size.height;
    return Center(
      child: SizedBox(
        height: screenHeight * 0.4,
        child: CubePageView.builder(
          itemCount: places.length,
          itemBuilder: (context, index, notifier) {
            final item = places[index];
            final transform = Matrix4.identity();
            final t = (index - notifier).abs();
            final scale = lerpDouble(1.5, 0, t);
            transform.scale(scale, scale);
            return CubeWidget(
              index: index,
              pageNotifier: notifier,
              child: Stack(
                children: [
                  Image.asset(
                    item.url,
                    height: screenHeight,
                    fit: BoxFit.cover,
                  ),
                  Transform(
                    alignment: Alignment.center,
                    transform: transform,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          decoration: const BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Colors.black45,
                              spreadRadius: 5,
                              blurRadius: 5,
                            ),
                          ]),
                          child: Text(
                            item.name.split('-').join('\n'),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            // style: Theme.of(context).textTheme.name,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
