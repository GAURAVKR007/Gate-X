import 'dart:ui';
import "dart:async";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gate_x/components/cards/card_widget.dart';
import 'package:gate_x/components/data_search.dart';
import 'package:gate_x/components/navbar/bottom_navbar.dart';
import 'package:gate_x/pages/homeScreens/components/expansion_list_topics_widget.dart';
import 'package:gate_x/pages/homeScreens/components/home_screen_resource_card.dart';
import 'package:gate_x/pages/homeScreens/components/home_screen_slider.dart';
import 'package:gate_x/pages/homeScreens/components/home_screen_subtitle.dart';
import 'package:gate_x/pages/homeScreens/components/pyq_widget.dart';
import 'package:gate_x/pages/homeScreens/components/swipeable_books_cards.dart';
import 'package:gate_x/providers/controllers/home_controller.dart';
import 'package:gate_x/providers/staticProviders/homepage_resouces_provider.dart';
import 'package:gate_x/providers/staticProviders/homepage_startlearning_provider.dart';
import 'package:gate_x/providers/user_providers.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:swipable_stack/swipable_stack.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, String> banners = {};
  bool isLoading = true; // Loading state

  late SwipableStackController _controller;
  @override
  void initState() {
    super.initState();

    loadBanners(); // Call the async function here
    _controller = SwipableStackController()..addListener(_listenController);
  }

  Future<void> loadBanners() async {
    try {
      QuerySnapshot response =
          await _firestore.collection("homescreenspotlight").get();

      if (response.docs.isEmpty) {
        Fluttertoast.showToast(
          msg: "No banners found",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        setState(() => isLoading = false);
        return;
      }

      for (var doc in response.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        data["bannersLink"].forEach((key, value) {
          if (key.isNotEmpty) {
            banners[key.toString()] = value?.toString() ?? '';
          }
        });
      }

      if (banners.isNotEmpty) {
        // No need to decode, banners is already a Map<String, String>
        ref.read(homeSliderProvider.notifier).updateBanners(banners);
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error loading banners -> ${e.toString()}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } finally {
      setState(() => isLoading = false); // Update loading state
    }
  }

  void _listenController() => setState(() {});

  @override
  void dispose() {
    super.dispose();
    _controller
      ..removeListener(_listenController)
      ..dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            collapsedHeight: 80,
            backgroundColor: const Color.fromRGBO(84, 62, 233, 1),
            expandedHeight: 190.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 10, bottom: 20),
              centerTitle: true,
              expandedTitleScale: 1,
              title: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      showSearch(context: context, delegate: DataSearch());
                    },
                    child: Container(
                      width: screenWidth * 0.9,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(12, 4, 46, 1),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.search,
                              color: Colors.white,
                              size: 40,
                            ),
                            // SizedBox(width: 20),
                            Text(
                              "Search",
                              style: TextStyle(
                                fontSize: 21,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
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
                          top: 1, bottom: 50, left: 15, right: 15),
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
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const HomeScreenSubtitle(subtitle: "Today's Spotlight"),
                  const SizedBox(height: 20),
                  isLoading
                      ? const Center(
                          child: Padding(
                          padding: EdgeInsets.all(28.0),
                          child: CircularProgressIndicator(),
                        ))
                      : HomeScreenSlider(
                          banners: ref.watch(homeSliderProvider).banners),
                  const SizedBox(height: 40),
                  const HomeScreenSubtitle(
                      subtitle: "Start Learning", seeAll: true),
                  SizedBox(
                    height: screenHeight * 0.710,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 0.65,
                      ),
                      itemCount: 4,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        return CardWidget(
                          data: ref.watch(homepageStartLearningProvider).data,
                          index: index,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  const HomeScreenSubtitle(subtitle: "Top Picks for Learning"),
                  const SizedBox(height: 20),
                  const ExpansionListTopicsWidget(),
                  const SizedBox(height: 20),
                  const HomeScreenSubtitle(subtitle: "Resources & Tools"),
                  SizedBox(
                    height: screenHeight * 0.370,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 0.67,
                      ),
                      itemCount: 8,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        return HomeScreenResourceCard(
                          data: ref.watch(homepageResourcesProvider).data,
                          index: index,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  const HomeScreenSubtitle(subtitle: "Top Books for Learning"),
                  const SizedBox(height: 20),
                  SwipeableBooksCards(
                    controller: _controller,
                    data: const [
                      {
                        "text": "Book 1",
                        "pdfUrl":
                            "http://139.59.56.236/bitstream/123456789/106/1/Introduction%20to%20Algorithms%20by%20Thomas%20%20H%20Coremen.pdf"
                      }
                    ],
                  ),
                  const SizedBox(height: 20),
                  const HomeScreenSubtitle(
                    subtitle: "Previous Year Paper's",
                    seeAll: true,
                  ),
                  const SizedBox(height: 20),
                  const PyqWidget(),
                  const SizedBox(height: 25),
                  const HomeScreenSubtitle(
                    subtitle: "Sample Paper's",
                    seeAll: true,
                  ),
                  const SizedBox(height: 20),
                  const PyqWidget(),
                  const SizedBox(height: 20),
                  const HomeScreenSubtitle(
                    subtitle: "Notes",
                    seeAll: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
