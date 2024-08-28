import 'package:flutter/material.dart';

class PyqWidget extends StatelessWidget {
  const PyqWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (int i = 0; i <= 24; i++)
            AdditionInfoCard(
              name: "Gate-${2000 + i}",
            ),
        ],
      ),
    );
  }
}

class AdditionInfoCard extends StatelessWidget {
  final String? name;
  const AdditionInfoCard({
    super.key,
    this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 7),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromRGBO(84, 62, 233, 1),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Image(
                color: Colors.white,
                height: 120,
                width: 90,
                image: AssetImage("assets/icons/exam-icon.png")),
            const SizedBox(height: 15),
            Text(
              "$name",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
