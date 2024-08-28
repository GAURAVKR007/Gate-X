import 'dart:ui';

import 'package:gate_x/components/data_search.dart';
import 'package:gate_x/providers/user_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeHeader extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: const Color.fromRGBO(84, 62, 233, 1),
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "Hello, \n${ref.watch(userProvider).user.username}",
                style: const TextStyle(
                  fontSize: 16, // Adjust size for the collapsed state
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              background: Card(
                color: const Color.fromRGBO(84, 62, 233, 1),
                elevation: 12,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 15, bottom: 30, left: 15, right: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  "Hello, \n${ref.watch(userProvider).user.username}",
                                  style: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const CircleAvatar(
                                backgroundColor: Color.fromRGBO(12, 4, 46, 1),
                                radius: 30,
                                child: Icon(
                                  color: Colors.white,
                                  Icons.notifications,
                                  size: 40,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  showSearch(context: context, delegate: DataSearch());
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(12, 4, 46, 1),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 40,
                        ),
                        SizedBox(width: 20),
                        Text(
                          "Search",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Add other slivers for content here
        ],
      ),
    );
  }
}
