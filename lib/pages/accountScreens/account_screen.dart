import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gate_x/components/navbar/bottom_navbar.dart';
import 'package:gate_x/pages/accountScreens/components/account_details_dashboards.dart';
import 'package:gate_x/pages/accountScreens/components/account_details_my_accounts_widget.dart';
import 'package:gate_x/providers/user_providers.dart';

class AccountScreen extends ConsumerStatefulWidget {
  const AccountScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AccountScreenState();
}

class _AccountScreenState extends ConsumerState<AccountScreen> {
  // TODO: show when the user has Joined the Platform
  // TODO: Make a way to show some Progress Points with Friends and make a way to Add Friends

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(top: 16.0, left: 8),
          child: Text(
            'Account Details',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 35,
                          child: Text(
                            "G",
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(255, 107, 107, 1),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ref.watch(userProvider).user.username,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                            const Text(
                              " Owner",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
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
                      Icons.edit_square,
                      size: 35,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 15),
              const Divider(
                color: Color.fromRGBO(255, 107, 107, 1),
                thickness: 1,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        "2+ hours",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "Total Learn",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  Container(
                    height: 40, // Set the height of the vertical divider
                    child: VerticalDivider(
                      color: Color.fromRGBO(255, 107, 107, 1), // Line color
                      thickness: 1, // Line thickness
                      width: 1, // Optional: set width if needed
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        "99",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "Achievements",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  Container(
                    height: 40, // Set the height of the vertical divider
                    child: VerticalDivider(
                      color: Color.fromRGBO(255, 107, 107, 1), // Line color
                      thickness: 1, // Line thickness
                      width: 1, // Optional: set width if needed
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        "999",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "Current Streak",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const AccountDetailsDashborad(),
              const SizedBox(height: 20),
              const AccountDetailsMyAccountWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
