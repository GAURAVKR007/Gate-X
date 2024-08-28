import 'dart:ui';

import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final List<Map<String, String>> data;
  final int index;
  const CardWidget({
    super.key,
    required this.index,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
          child: Container(
            height: 80,
            width: 100,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(84, 62, 233, 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image(
                    height: 140,
                    colorBlendMode: BlendMode.colorDodge,
                    width: 140,
                    fit: BoxFit.cover,
                    image: NetworkImage(data[index]['imageUrl']!),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      data[index]['subject']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 8.0, left: 8, bottom: 18, top: 2),
                  child: Text(
                    "${data[index]['chapters']} Chapters",
                    style: const TextStyle(
                        color: Color.fromRGBO(255, 107, 107, 1),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
