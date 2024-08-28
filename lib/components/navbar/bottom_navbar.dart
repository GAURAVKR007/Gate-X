import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
        color: Color.fromRGBO(84, 62, 233, 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 14),
        child: GNav(
          tabBorder: const Border(
            top: BorderSide(color: Color.fromRGBO(12, 4, 46, 0.8), width: 1),
            bottom: BorderSide(color: Color.fromRGBO(12, 4, 46, 0.8), width: 1),
          ),
          backgroundColor: const Color.fromRGBO(84, 62, 233, 1),
          color: Colors.white,
          activeColor: const Color.fromRGBO(255, 107, 107, 1),
          tabBackgroundColor: const Color.fromRGBO(12, 4, 46, 0.8),
          padding: const EdgeInsets.all(16),
          gap: 7,
          onTabChange: (index) {
            debugPrint("$index");
          },
          tabs: const [
            GButton(
              icon: Icons.home,
              text: "Home",
            ),
            GButton(
              icon: Icons.explore,
              text: "Explore",
            ),
            GButton(
              icon: Icons.forum_outlined,
              text: "Forum",
            ),
            GButton(
              icon: Icons.person,
              text: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
