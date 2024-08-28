import 'package:flutter/material.dart';

class HomeScreenResourceCard extends StatelessWidget {
  final List<Map<String, String>> data;
  final int index;
  const HomeScreenResourceCard({
    super.key,
    required this.data,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 20,
      padding: const EdgeInsets.only(left: 7, right: 7, bottom: 5, top: 5),
      // height: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromRGBO(84, 62, 233, 1).withOpacity(0.7),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            height: 73,
            width: 75,
            image: AssetImage("${data[index]['resourceIcon']}"),
          ),
          // const SizedBox(height: 5),
          Expanded(
            child: Text(
              "${data[index]["resourceText"]}",
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
