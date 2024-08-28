import 'package:gate_x/components/custom_appbar.dart';
import 'package:gate_x/pages/homeScreens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostRegister extends ConsumerStatefulWidget {
  final String username;
  const PostRegister({super.key, required this.username});

  @override
  ConsumerState<PostRegister> createState() => _PostRegisterState();
}

class _PostRegisterState extends ConsumerState<PostRegister> {
  int _currentIndex = 0;
  int _currentCharIndex = 0;

  late final List<String> badassGateQuotes;

  void typeWrittingAnimation() {
    if (_currentCharIndex < badassGateQuotes[_currentIndex].length) {
      _currentCharIndex++;
    } else {
      _currentIndex = (_currentIndex + 1) % badassGateQuotes.length;
      _currentCharIndex = 0;
    }

    setState(() {});

    Future.delayed(const Duration(milliseconds: 125), () {
      typeWrittingAnimation();
    });
  }

  @override
  void initState() {
    super.initState();
    badassGateQuotes = [
      "GATE, YOU'VE BEEN WARNED. ${widget.username} HAS ARRIVED.",
      "THE GATE EXAM WILL BURN. ${widget.username} WILL BE THE ONE HOLDING THE MATCH.",
      "GATE EXAM, YOU'VE BEEN HACKED. ${widget.username} IS NOW IN CONTROL.",
      "THE COUNTDOWN TO GATE EXAM DOMINATION HAS BEGUN. ${widget.username} IS THE TICKING TIME BOMB.",
      "GATE EXAM, MEET YOUR DOOM. ${widget.username} IS COMING FOR YOU."
    ];

    typeWrittingAnimation();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70), // Set the height of the app bar
        child: CustomAppbar(),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: screenWidth * 0.999,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Image(
                    image: AssetImage("assets/icons/small-stars-icon.png")),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image(image: AssetImage("assets/icons/big-stars-icon.png")),
                    SizedBox(width: 10),
                    Image(
                        image: AssetImage("assets/icons/small-stars-icon.png")),
                  ],
                ),
                const SizedBox(height: 50),
                const Text(
                  "Account Created\nSuccessfully!",
                  style: TextStyle(fontSize: 30, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50),
                SizedBox(
                  height: 125,
                  child: Text(
                    badassGateQuotes[_currentIndex]
                        .substring(0, _currentCharIndex),
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 100),
                SizedBox(
                  width: screenWidth * 0.99,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(84, 62, 233, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Let's Start",
                              style:
                                  TextStyle(fontSize: 24, color: Colors.white)),
                          SizedBox(width: 10),
                          Icon(Icons.arrow_forward_ios, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
