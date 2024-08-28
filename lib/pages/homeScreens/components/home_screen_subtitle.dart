import 'package:flutter/material.dart';

class HomeScreenSubtitle extends StatelessWidget {
  final String subtitle;
  final bool seeAll;
  const HomeScreenSubtitle({
    super.key,
    required this.subtitle,
    this.seeAll = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
            color: const Color.fromRGBO(255, 107, 107, 1).withOpacity(0.8),
            width: 2,
          ))),
          child: Text(
            "\t$subtitle ",
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 10),
        if (seeAll)
          Container(
            padding: const EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
              color: const Color.fromRGBO(255, 107, 107, 1).withOpacity(0.8),
              width: 2,
            ))),
            child: Row(
              children: [
                Text(
                  "See all",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 17,
                  color: Colors.white,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
