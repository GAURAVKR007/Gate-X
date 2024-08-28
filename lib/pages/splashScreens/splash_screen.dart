import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gate_x/pages/auth/signin_user.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const SigninUser()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Animate(
            effects: [FadeEffect(delay: 1000.ms)],
            child: Container(
              height: 5,
              width: 170,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Animate(
                effects: [SlideEffect(delay: 1000.ms)],
                child: Container(
                  height: 100,
                  width: 5,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 50),
              Center(
                child: Animate(
                  effects: [
                    FadeEffect(duration: 1200.ms),
                    ScaleEffect(delay: 1200.ms),
                  ],
                  child: (const Text(
                    "GATE-X",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  )),
                ),
              ),
              const SizedBox(width: 50),
              Animate(
                effects: [SlideEffect(delay: 1000.ms)],
                child: Container(
                  height: 100,
                  width: 5,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Animate(
            effects: [FadeEffect(delay: 1000.ms)],
            child: Container(
              height: 5,
              width: 170,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
