import 'package:flutter/material.dart';

class AccountDetailsDashborad extends StatelessWidget {
  const AccountDetailsDashborad({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromRGBO(255, 107, 107, 1),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: const Color.fromRGBO(255, 107, 107, 1).withOpacity(0.8),
                width: 2,
              ))),
              child: const Text(
                "Dashboard",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const DashboardItem(
              itemName: "Settings",
              icon: Icon(
                Icons.settings_suggest,
                size: 35,
                color: Color.fromRGBO(255, 107, 107, 1),
              ),
            ),
            const SizedBox(height: 20),
            const DashboardItem(
              itemName: "Achievements",
              icon: Icon(
                Icons.grade_outlined,
                size: 35,
                color: Color.fromRGBO(255, 107, 107, 1),
              ),
            ),
            const SizedBox(height: 20),
            const DashboardItem(
              itemName: "Statistics",
              icon: Icon(
                Icons.auto_graph_rounded,
                size: 35,
                color: Color.fromRGBO(255, 107, 107, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardItem extends StatelessWidget {
  final String itemName;
  final Icon icon;
  const DashboardItem({
    super.key,
    required this.itemName,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 25,
                child: icon,
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    itemName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(right: 5.0),
          child: Icon(
            Icons.navigate_next_outlined,
            size: 35,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
